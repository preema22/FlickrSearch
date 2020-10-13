//
//  PhotosViewModelTests.swift
//  FlickrSearchTests
//
//  Created by Preema DSouza on 11/10/2020.
//  Copyright © 2020 Preema DSouza. All rights reserved.
//

import XCTest
@testable import FlickrSearch

/// Tests for PhotosViewModel
class PhotosViewModelTests: XCTestCase {

    var sut: PhotosViewModel!

    override func setUpWithError() throws {
        sut = PhotosViewModel()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testPhotosCount() throws {
        let firstPhoto = Photo(id: "50452890813", secret: "d0f6d92506", server: "65535", farm: 66)
        let secondPhoto = Photo(id: "50453754532", secret: "c2c2fda5a0", server: "65535", farm: 66)
        let thirdPhoto = Photo(id: "50453564511", secret: "8a70de8350", server: "65535", farm: 66)

        let photos = [firstPhoto, secondPhoto, thirdPhoto]
        sut.photos.value = photos
        XCTAssertEqual(sut.numberOfPhotos(), photos.count)
    }

    func testPhotoViewModelForIndex() throws {
        let firstPhoto = Photo(id: "50452890813", secret: "d0f6d92506", server: "65535", farm: 66)
        let secondPhoto = Photo(id: "50453754532", secret: "c2c2fda5a0", server: "65535", farm: 66)
        let thirdPhoto = Photo(id: "50453564511", secret: "8a70de8350", server: "65535", farm: 66)

        let photos = [firstPhoto, secondPhoto, thirdPhoto]
        sut.photos.value = photos
        let photoViewModel = PhotoViewModel(photo: firstPhoto)
        let sutPhotoViewModel = sut.photoViewModel(for: 0)
        XCTAssertEqual(photoViewModel.photoImage.value, sutPhotoViewModel.photoImage.value)
    }
}
