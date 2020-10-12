//
//  PhotoViewModel.swift
//  FlickrSearch
//
//  Created by Preema DSouza on 11/10/2020.
//  Copyright © 2020 Preema DSouza. All rights reserved.
//

import Foundation

struct PhotoViewModel {
    let photoImage: Dynamic<String>
    
    init(photo: Photo) {
        self.photoImage = Dynamic("http://farm\(photo.farm).static.flickr.com/\(photo.server)/\(photo.id)_\(photo.secret).jpg")
    }
}
