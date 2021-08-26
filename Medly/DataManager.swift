//
//  DataManager.swift
//  Medly
//
//  Created by Jason Crispell on 2021-08-26.
//

import Foundation

typealias DataManagerCompletion<T> = (_: T?, _: Error?) -> Void

class DataManager {
    
    private let networkManager = NetworkManager()
    
    func getCountries(completionHandler: @escaping DataManagerCompletion<[CountryObject]>) {
    
        networkManager.getCountries { data, error in
            
            guard let data = data else {
                // Complete with error
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let countries = try decoder.decode([CountryObject].self, from: data)
                completionHandler(countries, nil)
            } catch {
                return
            }
        }
    }
    
}
