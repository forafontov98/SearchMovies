//
//  MovieViewController.swift
//  TestApp
//
//  Created by Владислав Форафонтов on 11.05.2018.
//  Copyright © 2018 Владислав Форафонтов. All rights reserved.
//

import UIKit

// controller movie-info's screen
class MovieViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var overview: UILabel!
    
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if movie != nil {            
            setup()
            
            movie?.getPoster() { [weak self] image in
                self?.posterImageView.image = image
                self?.activity.stopAnimating()
                self?.posterImageView.backgroundColor = .clear
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // cancelled request - it needs, if we haven't recieved answer and leave screen (save traffic)
        NetworkManager.manager.cancelRequest(with: movie?.info?.poster_path)
    }
    
    
    // set all info-variables
    private func setup() {
        if let _movie = movie {
            nameLabel.text = _movie.info?.title
            dateLabel.text = _movie.stringDate
            overview.text = _movie.info?.overview
            
            if let _info = _movie.info {
                rateLabel.text = "Рейтинг: \(_info.vote_average)/10"
            }
        }
    }
}
