//
//  DataManager.swift
//  FlickrSearch
//
//  Created by Preema DSouza on 11/10/2020.
//  Copyright © 2020 Preema DSouza. All rights reserved.
//

import Foundation

class DataManager {
    
    private lazy var workingContext = {PersistenceService.shared.context}()
    
    /// Helper to create Core Data entry
    /// - Parameter historyString: Search term entered by the user
    func save(historyString: String) {
        HistoryEntityHandler().create(with: historyString, context: workingContext)
        PersistenceService.shared.saveContext()
    }
}
