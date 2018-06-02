//
//  RoundedButton.swift
//  TestApp
//
//  Created by Владислав Форафонтов on 12.05.2018.
//  Copyright © 2018 Владислав Форафонтов. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        config()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        config()
    }
    
    func config() {
        titleLabel?.font = UIFont.systemFont(ofSize: 17.0, weight: .medium)
        
        clipsToBounds = false
        layer.cornerRadius = self.bounds.height / 2
    }
}
