//
//  Service.swift
//  FlickrSearch
//
//  Created by Preema DSouza on 10/10/2020.
//  Copyright © 2020 Preema DSouza. All rights reserved.
//

import Foundation

class Service {
    
    static let shared = Service()
    
    func fetchPhotos(searchTerm: String, page: Int, completion: @escaping (Result<Photos, Error>) -> Void) {
        let urlString = Constants.fetchUrl + "&text=\(searchTerm)" + "&page=\(page)"
        guard let url = URL(string: urlString) else {
            return
        }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                completion(.failure(error))
            }
            guard let data = data else {
                return
            }
            do {
                let searchResult = try JSONDecoder().decode(PhotosResult.self, from: data)
                if searchResult.stat == "ok", let photos = searchResult.photos {
                    completion(.success(photos))
                } else {
                    completion(.failure(AppError.stat))
                }
                
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
}
