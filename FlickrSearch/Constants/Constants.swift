//
//  Constants.swift
//  FlickrSearch
//
//  Created by Preema DSouza on 10/10/2020.
//  Copyright © 2020 Preema DSouza. All rights reserved.
//

import Foundation

struct Constants {
    
    private init() { }
    
    static let apiKey = "11c40ef31e4961acf4f98c8ff4e945d7"
    static let fetchUrl = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(apiKey)&format=json&nojsoncallback=1&"
        
}
