//
//  PhotosViewModel.swift
//  FlickrSearch
//
//  Created by Preema DSouza on 10/10/2020.
//  Copyright © 2020 Preema DSouza. All rights reserved.
//

import Foundation

/// ViewModel for PhotosViewController
class PhotosViewModel {
    
    let photos: Dynamic<[Photo]>
    let currentPage: Dynamic<Int>
    let totalPages: Dynamic<Int>
    let errorMessage: Dynamic<String?>
    private let searchString: Dynamic<String>
    
    init() {
        photos = Dynamic([])
        currentPage = Dynamic(0)
        totalPages = Dynamic(0)
        searchString = Dynamic("")
        errorMessage = Dynamic(nil)
    }
    
    /// Helper for number of rows
    func numberOfPhotos() -> Int {
        return photos.value.count
    }
    
    /// Helper for cell
    func photoViewModel(for index: Int) -> PhotoViewModel {
        return PhotoViewModel(photo: photos.value[index])
    }
    
}

// MARK: - Search

extension PhotosViewModel {
    
    /// Method for validating the search term and calls the saveSerachTerm and getPhotos method
    /// - Parameter searchTerm: Search term entered by the user
    func seachPhotos(searchTerm: String?) {
        guard let searchText = searchTerm?.trimmingCharacters(in: .whitespacesAndNewlines), !searchText.isEmpty else {
            return
        }
        self.searchString.value = searchText
        saveSearchTerm(text: searchText)
        getPhotos(for: searchText)
    }
    
    /// Method to validate and fetch more results when user scrolls to the bottom of the screen
    func fetchMorePhotos() {
        guard currentPage.value < totalPages.value, !searchString.value.isEmpty else {
            return
        }
        getPhotos(for: searchString.value, page: currentPage.value + 1)
    }
    
    /// Method that is reponsible for getting API response
    /// - Parameters:
    ///   - searchTerm: search term entered by the user
    ///   - page: page number, used to fetch more results when user scrolls to the bottom of the screen
    private func getPhotos(for searchTerm: String, page: Int = 1) {
        Service.shared.fetchPhotos(searchTerm: searchTerm, page: page) {[weak self] result in
            switch result {
            case .success(let photos):
                if page == 1 {
                    self?.photos.value = photos.photo
                } else {
                    self?.photos.value += photos.photo
                }
                self?.currentPage.value = photos.page
                self?.totalPages.value = photos.pages
            case .failure(let error):
                self?.errorMessage.value = error.localizedDescription
            }
        }
    }    
        
}

// MARK: - Search term persist

extension PhotosViewModel {
    /// Method responsible for persisting the search term entered by the user
    /// - Parameter text: search term entered by user
    private func saveSearchTerm(text: String) {
        let dataManager = DataManager()
        dataManager.save(historyString: text)
    }
}
