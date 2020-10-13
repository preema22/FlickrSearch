//
//  Photos.swift
//  FlickrSearch
//
//  Created by Preema DSouza on 10/10/2020.
//  Copyright © 2020 Preema DSouza. All rights reserved.
//

import Foundation

/// Model for API response
struct PhotosResult: Decodable {
    let stat: String?
    let photos: Photos?
}

struct Photos: Decodable {
    let photo: [Photo]
    let page: Int
    let pages: Int
}
