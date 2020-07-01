//
//  Forecast.swift
//  ProtonTest
//
//  Created by Sergey Chehuta on 19/03/2020.
//  Copyright © 2020 Proton Technologies AG. All rights reserved.
//

import UIKit

enum Weather: String {
    case Sunny
    case SunnyShowers = "Sunny with showers"
    case Rain
    case Thunder = "Thunder and rain"
    case Showers
    case Windy
    case Cloudy = "Clowdy with showers"
    case Overcast
    case Unknown

    init(string: String) {
        self = Weather(rawValue: string) ?? .Unknown
    }
}


struct Forecast {
    
    let chance_rain: Double
    let description: Weather
    let sunrise: Int
    let sunset: Int
    let low: Double
    let high: Double
    let day: Int
    let imageURL: String?
    
    var image: UIImage?
    
    init(dictionary d: NSDictionary) {
        
//        print(d)
        
        self.chance_rain = d.doubleValue("chance_rain")
        self.description = Weather(string: d.stringValue("description"))

        self.sunrise = d.intValue("sunrise")
        self.sunset  = d.intValue("sunset")

        self.low  = d.doubleValue("low")
        self.high = d.doubleValue("high")

        self.day   = Int(d.stringValue("day")) ?? 0
        self.imageURL = d.string("image")
    }
    
    static func getList(_ array: [NSDictionary]) -> [Forecast] {
        var result = [Forecast]()
        
        array.forEach { (d) in
            result.append(Forecast(dictionary: d))
        }
        
        return result
    }
}

extension Forecast {
 
    var info: String? {
        return [
            "\(self.day)",
            self.description.rawValue
        ].joined(separator: ": ")
    }
 
    var hasImage: Bool {
        return self.image != nil
    }

    var sunriseString: String {
        return timeString(self.sunrise)
    }
    
    var sunsetString: String {
        return timeString(self.sunset)
    }
    
    var lowString: String {
        return "\(self.low)ºC"
    }
    
    var highString: String {
        return "\(self.high)ºC"
    }
    
    var chanceString: String {
        return "\(self.chance_rain)%"
    }
    
    func timeString(_ value: Int) -> String {
        let sec   = value % 3600 % 60
        let min   = value % 3600 / 60
        let hours = value / 3600
        return String(format: "%02d:%02d:%02d", hours, min, sec)
    }
    
}
