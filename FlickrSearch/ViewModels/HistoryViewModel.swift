//
//  HistoryViewModel.swift
//  FlickrSearch
//
//  Created by Preema DSouza on 11/10/2020.
//  Copyright © 2020 Preema DSouza. All rights reserved.
//

import UIKit
import CoreData

/// ViewModel for HistoryViewController
struct HistoryViewModel {
    private var searchHistory: [History] = []
    
    /// Helper for number of rows
    var numberOfSearchTerms: Int {
        searchHistory.count
    }
    
    /// Fetches the search terms history from Core Data
    init() {
        let users = PersistenceService.shared.fetch(History.self)
        searchHistory = users.compactMap { $0 }
    }
    
    /// Helper for cell
    func searchTerm(for index: Int) -> String {
        searchHistory[index].searchText ?? ""
    }
}
