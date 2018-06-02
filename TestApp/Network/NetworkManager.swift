//
//  Network.swift
//  TestApp
//
//  Created by Владислав Форафонтов on 11.05.2018.
//  Copyright © 2018 Владислав Форафонтов. All rights reserved.
//

import UIKit
import Alamofire

class NetworkManager {
    
    // singleton
    static let manager = NetworkManager()
    private init() {}
    
    // get image on url and perform completion after receiveng
    func getImage(with url: String, completion: @escaping(UIImage) -> ()) {
        Alamofire.request(url).response { response in
            if let data = response.data, let image = UIImage(data: data) {
                completion(image)
            }
        }
    }
    
    
    // get json on search-string and returns objects array
    func getFilms(with search: String, completion: @escaping(Data) -> ()) {
        
        let url = URL.searchBase + "?api_key=" + URL.key + "&query=" + search.replacingOccurrences(of: " ", with: "+") + "&language=" + LanguageID.rus
        
        Alamofire.request(url.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!).responseJSON { (response) in
            switch response.result {
            case .success:
                if let data = response.data {
                    completion(data)
                }
            case .failure(let error): print(error)
            }
        }
    }
    
    // cancel all requests, if request contains "url" string
    func cancelRequest(with url: String?) {
        guard url != nil else {return}
        
        Alamofire.SessionManager.default.session.getAllTasks { (tasks) in
            
            tasks.forEach {
                if ($0.originalRequest?.url?.absoluteString.contains(url!))! {
                    $0.cancel()
                }
            }
        }
    }
}
