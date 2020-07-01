//
//  ForecastCell.swift
//  ProtonTest
//
//  Created by Sergey Chehuta on 19/03/2020.
//  Copyright © 2020 Proton Technologies AG. All rights reserved.
//

import UIKit

class ForecastCell: UITableViewCell {
    
    var forecast: Forecast? {
        didSet {
            updateContent()
        }
    }

    func updateContent() {
        self.textLabel?.textColor = true == self.forecast?.hasImage ? .black : .gray
        self.textLabel?.text = self.forecast?.info
        self.imageView?.image = self.forecast?.image
    }

}
