//
//  DetailsHeader.swift
//  ProtonTest
//
//  Created by Sergey Chehuta on 19/03/2020.
//  Copyright © 2020 Proton Technologies AG. All rights reserved.
//

import UIKit

class DetailsHeader: UIView {
    
    let iv = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.iv)
        self.iv.frame = self.bounds
        self.iv.autoresizingMask = [ .flexibleWidth, .flexibleHeight ]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

