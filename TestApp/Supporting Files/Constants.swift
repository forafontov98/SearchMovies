//
//  Constants.swift
//  TestApp
//
//  Created by Владислав Форафонтов on 11.05.2018.
//  Copyright © 2018 Владислав Форафонтов. All rights reserved.
//

// file has all constants, that we need in app
import Foundation


/* ----------------------------------
    enumeration has all we need URL's
    URL for image receiving construct like that:
        smallImageBase + {imageCode, получаемый в теле json'a в поиске} - for small images
        originalImageBase + {imageCode that we've recieved in json} - for original image
*/
enum URL {
    static let smallImageBase = "https://image.tmdb.org/t/p/w500"
    static let originalImageBase = "https://image.tmdb.org/t/p/original"
    
    static let searchBase = "https://api.themoviedb.org/3/search/movie"
    static let key = "c33e25174af866c5c102772d92d0e480"
}


/* ----------------------------------
    Enum has all language id's for construct URL
*/
enum LanguageID {
    static let rus = "ru-RU"
}

/* ----------------------------------
    Enum of conditions of view's object. It needs for their showing
 */
enum ShowConditions {
    case tableView
    case notFound
    case activity
}
