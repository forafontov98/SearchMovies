//
//  MovieTableViewCell.swift
//  TestApp
//
//  Created by Владислав Форафонтов on 13.05.2018.
//  Copyright © 2018 Владислав Форафонтов. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var icon: IconImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var rate: UILabel!
    @IBOutlet weak var date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func update(movie: Movie) {
        name.text = movie.info?.title
        icon.image = movie.icon
        date.text = movie.stringDate
        
        if let rate = movie.info?.vote_average {
            self.rate.text = "\(rate)/10"
        }
    }
}
