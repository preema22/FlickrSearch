//
//  AppError.swift
//  FlickrSearch
//
//  Created by Preema DSouza on 12/10/2020.
//  Copyright © 2020 Preema DSouza. All rights reserved.
//

import Foundation

/// Custom error for API response
enum AppError: Error {
    case stat
}

extension AppError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .stat:
            return "Api returned an error"
        }
    }
}
