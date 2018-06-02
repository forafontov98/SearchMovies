//
//  Movie.swift
//  TestApp
//
//  Created by Владислав Форафонтов on 11.05.2018.
//  Copyright © 2018 Владислав Форафонтов. All rights reserved.
//

import UIKit

class Movie {
    private(set) var icon: UIImage?
    private(set) var poster: UIImage?        // it's original image of icon
    private(set) var dateRelease: Date?
    private(set) var info: MovieInfo?       // all info-variables of movie

    let dateFormatter = DateFormatter()      // for transform date
    
    init(with info: MovieInfo) {
        self.info = info
        
        dateFormatter.dateFormat = "yyyy-dd-MM"
        dateRelease = dateFormatter.date(from: info.release_date)
    }
    
    // returns string of date in format dd.MM.yyyy (or nil)
    var stringDate: String? {
        get {
            if let date = dateRelease {
                dateFormatter.dateFormat = "dd.MM.yyyy"
                return dateFormatter.string(from: date)
            }
            return nil
        }
    }
    
    // get icon from server
    func getIcon(completion: @escaping(UIImage) -> ()) {
        guard (info != nil) && (info?.poster_path != nil) else {return}
        
        let url = URL.smallImageBase + info!.poster_path
        NetworkManager.manager.getImage(with: url) { [weak self] image in
            self?.icon = image
            completion(image)
        }
    }
    
    // get poster from server 
    func getPoster(completion: @escaping(UIImage) -> ()) {
        guard (info != nil) && (info?.poster_path != nil) else {return}

        let url = URL.originalImageBase + info!.poster_path
        NetworkManager.manager.getImage(with: url) { [weak self] image in
            self?.poster = image
            completion(image)
        }
    }
}

// JSON of movie from server
struct MovieJSON: Codable {
    let page: Int
    let total_results: Int
    let total_pages: Int
    let results: [MovieInfo]
}

// variables of movie that we need
struct MovieInfo: Codable {
    let poster_path: String     // imageCode, need for create url
    let overview: String
    let release_date: String
    let title: String           // film's name
    let vote_average: Double    // film's rate
}
