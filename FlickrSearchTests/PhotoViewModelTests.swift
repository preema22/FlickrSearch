//
//  PhotoViewModelTests.swift
//  FlickrSearchTests
//
//  Created by Preema DSouza on 11/10/2020.
//  Copyright © 2020 Preema DSouza. All rights reserved.
//

import XCTest
@testable import FlickrSearch

/// Tests for PhotoViewModel
class PhotoViewModelTests: XCTestCase {

    var sut: PhotoViewModel!

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testPhotoViewModel() throws {
        let photo = Photo(id: "50452890813", secret: "d0f6d92506", server: "65535", farm: 66)
        sut = PhotoViewModel(photo: photo)
        XCTAssertEqual(sut.photoImage.value, "http://farm\(photo.farm).static.flickr.com/\(photo.server)/\(photo.id)_\(photo.secret).jpg")
    }

}
