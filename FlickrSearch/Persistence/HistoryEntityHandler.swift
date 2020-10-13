//
//  HistoryEntityHandler.swift
//  FlickrSearch
//
//  Created by Preema DSouza on 11/10/2020.
//  Copyright © 2020 Preema DSouza. All rights reserved.
//

import Foundation
import CoreData

class HistoryEntityHandler: NSObject {
    
    /// Method to fetch search term history from Core Data
    /// - Returns: Returns History (Entity) fetch result
    func fetchRequest() -> NSFetchRequest<NSFetchRequestResult>? {
        return History.fetchRequest()
    }
    
    /// Method to check existence and eliminate duplicate entry search term in History entity, Core Data
    /// - Parameters:
    ///   - text: search term to be saved
    ///   - context: NSManagedObjectContext
    func create(with text: String, context: NSManagedObjectContext) {
        var userHistory: History!
        if let history = self.historyWithSearchText(searchText: text, context: context) {
            userHistory = history
        }
        else {
            userHistory = History(entity: History.entity(), insertInto: context)
        }
        userHistory.searchText = text
    }
    
    /// Method to fetch existing entry of search term as History Entity, Core Data
    /// - Parameters:
    ///   - searchText: Search term entered by the user
    ///   - context: NSManagedObjectContext
    /// - Returns: Optional History entity
    func historyWithSearchText(searchText: String, context: NSManagedObjectContext) -> History? {
        let fetchRequest = self.fetchRequest()
        fetchRequest?.predicate = NSPredicate(format: "searchText = %@", searchText)
        
        do {
            let fetchedObject = try context.fetch(fetchRequest!)
            if let fetchedObject = fetchedObject  as? [History], !fetchedObject.isEmpty {
                return fetchedObject.first
            }
            return nil
        } catch {
            return nil
        }
    }
}
