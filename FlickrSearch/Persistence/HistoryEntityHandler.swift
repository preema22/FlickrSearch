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
    
    func fetchRequest() -> NSFetchRequest<NSFetchRequestResult>? {
        return History.fetchRequest()
    }
    
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
    
    func historyWithSearchText(searchText: String, context: NSManagedObjectContext) -> History?  {
        let fetchRequest = self.fetchRequest()
        fetchRequest?.predicate = NSPredicate(format: "searchText = %@", searchText)
        
        do {
            let fetchedObject = try context.fetch(fetchRequest!)
            if let fetchedObject = fetchedObject  as? [History], fetchedObject.count > 0 {
                return fetchedObject.first
            }
            return nil
        } catch {
            return nil
        }
    }
}
