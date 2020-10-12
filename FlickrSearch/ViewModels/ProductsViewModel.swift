//
//  ProductsViewModel.swift
//  FlickrSearch
//
//  Created by Preema DSouza on 10/10/2020.
//  Copyright © 2020 Preema DSouza. All rights reserved.
//

import Foundation

struct PhotossViewModel {
    
    let photos: Dynamic<[Photo]>
    let currentPage: Dynamic<Int>
    let totalPages: Dynamic<Int>
    let errorMessage: Dynamic<String>
    private let searchString: Dynamic<String>
    
    init() {
        self.photos = Dynamic([])
        self.currentPage = Dynamic(0)
        self.totalPages = Dynamic(0)
        self.errorMessage = Dynamic("")
        self.searchString = Dynamic("")
    }
    
}

extension PhotossViewModel {
        
    func seachProducts(searchTerm: String?) {
        guard let searchText = searchTerm?.trimmingCharacters(in: .whitespacesAndNewlines), !searchText.isEmpty else {
            return
        }
        self.searchString.value = searchText
        saveSearchTerms()
        getSearchProducts(searchTerm: searchText)
    }
    
    func fetchMoreProducts() {
        guard currentPage.value < totalPages.value, !searchString.value.isEmpty else {
            return
        }
        getSearchProducts(searchTerm: searchString.value, page: currentPage.value + 1)
    }
    
    private func getSearchProducts(searchTerm: String, page: Int = 1) {
        Service.shared.fetchPhotos(searchTerm: searchTerm, page: page) { result in
            switch result {
            case .success(let photos):
                if page == 1 {
                    self.photos.value = photos.photo
                } else {
                    self.photos.value += photos.photo
                }
                self.currentPage.value = photos.page
                self.totalPages.value = photos.pages
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    private func saveSearchTerms(){
        var searchArray: [String]
        if let seachHistory = UserDefaults.standard.stringArray(forKey: "SearchHistory") {
            searchArray = seachHistory
            searchArray.append(self.searchString.value)
        }
        else  {
            searchArray = [searchString.value]
        }
        UserDefaults.standard.set(searchArray, forKey: "SearchHistory")
    }
        
}
