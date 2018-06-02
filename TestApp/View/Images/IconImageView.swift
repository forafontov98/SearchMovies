//
//  IconImageView.swift
//  TestApp
//
//  Created by Владислав Форафонтов on 11.05.2018.
//  Copyright © 2018 Владислав Форафонтов. All rights reserved.
//

import UIKit

// class icon in tableViewCell of films (with rounded corners)
class IconImageView: UIImageView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        clipsToBounds = true
        layer.cornerRadius = frame.width / 2
    }
}
