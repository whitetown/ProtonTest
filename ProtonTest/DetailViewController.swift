//
//  DetailViewController.swift
//  ProtonTest
//
//  Created by Robert Patchett on 07.02.19.
//  Copyright © 2019 Proton Technologies AG. All rights reserved.
//

import UIKit

enum DetailsSections: CaseIterable {
    case forecast
    case sunrise
    case sunset
    case high
    case low
    case chance
    
    var title: String {
        switch self {
        case .forecast:
            return "Forecast"
        case .sunrise:
            return "Sunrise"
        case .sunset:
            return "Sunset"
        case .high:
            return "High"
        case .low:
            return "Low"
        case .chance:
            return "Chance of rain"
        }
    }
}

class DetailViewController: UITableViewController {

    var onImage: ((UIImage?)->Void)?
    
    var forecast: Forecast?
    private let header = DetailsHeader(frame: CGRect(x: 0, y: 0, width: 300, height: 300))

    private let items = DetailsSections.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    func initialize() {
        self.title = self.forecast?.info
        
        self.tableView.register(DetailsCell.self, forCellReuseIdentifier: DetailsCell.identifier)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableHeaderView = self.header
        self.tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureView()
    }
    
    func configureView() {
        
        if let image = self.forecast?.image {
            self.header.iv.image = image
        } else {
            if let forecastUrl = URL(string: self.forecast?.imageURL ?? "") {
                let imageDownloadSession = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
                imageDownloadSession.dataTask(with: forecastUrl, completionHandler: { [weak self] (data, response, error) in
                    self?.applyImage(data)
                }).resume()
            }
        }
    }
    
    func applyImage(_ data: Data?) {
        guard let data = data else { return }
        DispatchQueue.main.async {
            let image = UIImage(data: data)
            self.header.iv.image = image
            self.onImage?(image)
        }
    }

}

extension DetailViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailsCell.identifier, for: indexPath)
        cell.textLabel?.text = self.items[indexPath.row].title
        return cell
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        switch self.items[indexPath.row] {
            
        case .forecast:
            cell.detailTextLabel?.text = self.forecast?.description.rawValue
        case .sunrise:
            cell.detailTextLabel?.text = self.forecast?.sunriseString
        case .sunset:
            cell.detailTextLabel?.text = self.forecast?.sunsetString
        case .high:
            cell.detailTextLabel?.text = self.forecast?.highString
        case .low:
            cell.detailTextLabel?.text = self.forecast?.lowString
        case .chance:
            cell.detailTextLabel?.text = self.forecast?.chanceString
        }
    }
    
}
