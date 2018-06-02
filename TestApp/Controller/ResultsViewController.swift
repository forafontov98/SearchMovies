//
//  ResultsViewController.swift
//  TestApp
//
//  Created by Владислав Форафонтов on 11.05.2018.
//  Copyright © 2018 Владислав Форафонтов. All rights reserved.
//

import UIKit
import SwiftyJSON

// controller results of searching
class ResultsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var notFoundLabel: UILabel!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    var movies: [Movie] = []
    var searchText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let search = searchText {
            show(obj: .activity)
            
            // get films with search-string
            NetworkManager.manager.getFilms(with: search) { [weak self] data in
                do {
                    let movieJSON = try JSONDecoder().decode(MovieJSON.self, from: data)
                    
                    for obj in movieJSON.results {
                        self?.movies.append(Movie(with: obj))
                    }
                } catch let error {
                    print(error)
                }
                
                guard self != nil else {return}
                if !self!.movies.isEmpty {
                    self?.show(obj: .tableView)
                    self?.tableView.reloadData()
                } else {
                    self?.show(obj: .notFound)
                }
            }
        } else {
            show(obj: .notFound)
        }
    }
    
    // this func show view's object, that we need and hide others.
    // for example: if we need show tableView, func show tableView and hide notFoundLabel and activity
    private func show(obj: ShowConditions) {
        tableView.isHidden = true
        notFoundLabel.isHidden = true
        activity.stopAnimating()
        
        switch(obj) {
        case .tableView: tableView.isHidden = false
        case .activity: activity.startAnimating()
        case .notFound: notFoundLabel.isHidden = false
        }
    }
}

extension ResultsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("MovieTableViewCell", owner: self, options: nil)?.first as! MovieTableViewCell
        cell.update(movie: movies[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard (cell as! MovieTableViewCell).icon.image == nil else {return}
        
        self.movies[indexPath.row].getIcon() { image in
            (cell as! MovieTableViewCell).icon.image = image
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MovieViewController") as! MovieViewController
        vc.movie = movies[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
