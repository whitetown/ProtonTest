//
//  MasterViewController.swift
//  ProtonTest
//
//  Created by Robert Patchett on 07.02.19.
//  Copyright © 2019 Proton Technologies AG. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
    
    @IBOutlet weak var sortingControl: UISegmentedControl!
    
    private var hottest = [Forecast]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    private var objects = [Forecast]() {
        didSet {
            getHottest()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private var order = 0 {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    private var items: [Forecast] {
        return self.order == 1 ? self.hottest : self.objects
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
        self.loadData()

        self.sortingControl.addTarget(self, action: #selector(sortingControlAction), for: .valueChanged)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }

    @objc func sortingControlAction(_ segmentedControl: UISegmentedControl) {
        self.order = self.sortingControl.selectedSegmentIndex
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ForecastCell.identifier, for: indexPath)
        (cell as? ForecastCell)?.forecast = self.items[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = DetailViewController()
        vc.forecast = self.items[indexPath.row]
        let day = self.items[indexPath.row].day
        vc.onImage = { [weak self] image in
            self?.onImage(image, at: day)
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

private extension MasterViewController {
    
    func onImage(_ image: UIImage?, at day: Int) {
        if let index = self.objects.firstIndex(where: { (f) -> Bool in
            f.day == day
        }) {
            self.objects[index].image = image
        }
        if let index = self.hottest.firstIndex(where: { (f) -> Bool in
            f.day == day
        }) {
            self.hottest[index].image = image
        }
    }
    
    func initialize() {
        self.tableView.register(ForecastCell.self, forCellReuseIdentifier: ForecastCell.identifier)
        self.tableView.tableFooterView = UIView()
        
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(loadData))
        self.navigationItem.rightBarButtonItems = [refresh]
    }

    @objc func loadData() {
        API.shared.getForecast { [weak self] (result) in
            switch result {
            case .success(let items):
                self?.objects = items
            case .failure(let error):
                print(error)
                self?.objects = []
            }
        }
    }
    
    func getHottest() {
        var hottest = items.filter { $0.chance_rain < 0.5 }
        hottest.sort { (a, b) -> Bool in
            return a.high > b.high
        }
        self.hottest = hottest
    }
    
}
