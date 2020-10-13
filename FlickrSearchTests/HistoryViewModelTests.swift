//
//  HistoryViewModelTests.swift
//  FlickrSearchTests
//
//  Created by Preema DSouza on 11/10/2020.
//  Copyright © 2020 Preema DSouza. All rights reserved.
//

import XCTest
@testable import FlickrSearch

class HistoryViewModelTests: XCTestCase {
    var sut: HistoryViewModel!
    var mainSut: PhotosViewModel!

    override func setUpWithError() throws {
        mainSut = PhotosViewModel()
        sut = HistoryViewModel()
    }

    override func tearDownWithError() throws {
        sut = nil
        mainSut = nil
    }

    func testHistoryExists() throws {
        mainSut.seachPhotos(searchTerm: "kittens")
        XCTAssertNotNil(sut.numberOfSearchTerms)
    }
}
