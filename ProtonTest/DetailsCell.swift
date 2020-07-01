//
//  DetailsCell.swift
//  ProtonTest
//
//  Created by Sergey Chehuta on 19/03/2020.
//  Copyright © 2020 Proton Technologies AG. All rights reserved.
//

import UIKit

class DetailsCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
