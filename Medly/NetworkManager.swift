//
//  NetworkManager.swift
//  Medly
//
//  Created by Jason Crispell on 2021-08-26.
//

import Foundation

typealias NetworkManagerCompletion = (_: Data?, _: Error?) -> Void

class NetworkManager {
    
    private let restCountriesAuthority: IRestCountriesAuthority = RestCountriesAuthority()
    
    func getCountries(completionHandler: @escaping NetworkManagerCompletion) {
        guard let request = restCountriesAuthority.buildCountriesRequest().0 else {
//            completionHandler()
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Check response code
            // Return error in completion handler
            
            if let data = data {
                DispatchQueue.main.async {
                    completionHandler(data, nil)
                }
            }
        }
        task.resume()
        
    }
}
