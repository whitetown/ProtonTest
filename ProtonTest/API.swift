//
//  API.swift
//  ProtonTest
//
//  Created by Sergey Chehuta on 19/03/2020.
//  Copyright © 2020 Proton Technologies AG. All rights reserved.
//

import Foundation

class API {
    
    static let shared = API()

    private let forecastURL = "https://5c5c8ba58d018a0014aa1b24.mockapi.io/api/forecast"
    
    func getForecast(_ completion: @escaping ((Result<[Forecast],Error>)->Void)) {
        weak var welf = self
        if let forecastUrl = URL(string: self.forecastURL) {
            URLSession.shared.dataTask(with: forecastUrl,
                                       completionHandler: { [weak self] (data, response, error) in
                                   
                    if let error = error {
                        if let data = self?.readData() {
                            completion(.success(welf?.parse(data) ?? []))
                        } else {
                            completion(.failure(error))
                        }
                    } else {
                        self?.saveData(data)
                        completion(.success(welf?.parse(data) ?? []))
                    }
            }).resume()
        } else {
            completion(.success([]))
        }
    }
    
    private func parse(_ data: Data?) -> [Forecast] {

        if  let data = data,
            let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as AnyObject,
            let array = json as? [NSDictionary] {

            return Forecast.getList(array)
        } else {
            return []
        }
    }
    
    private func file() -> URL? {
        guard let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else { return nil }
//        print(dir)
        return dir.appendingPathComponent("forecast.json")
    }

    private func saveData(_ data: Data?) {
        if let url = file() {
            try? data?.write(to: url, options: .atomic)
        }
    }
    
    private func readData() -> Data? {
        if let url = file() {
            return try? Data(contentsOf: url)
        }
        return nil
    }
    
}
