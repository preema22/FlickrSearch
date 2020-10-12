//
//  Photo.swift
//  FlickrSearch
//
//  Created by Preema DSouza on 10/10/2020.
//  Copyright © 2020 Preema DSouza. All rights reserved.
//

import Foundation

struct Photo: Decodable {
    let id: String
    let secret: String
    let server: String
    let farm: Int
}
