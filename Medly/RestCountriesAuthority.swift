//
//  RestCountriesAuthority.swift
//  Medly
//
//  Created by Jason Crispell on 2021-08-26.
//

import Foundation

protocol IAuthority {
    var baseUrl: String { get }
}

protocol IRestCountriesAuthority: IAuthority {
    var getCountriesEndpoint: String { get }
    
    func buildCountriesRequest() -> (URLRequest?, Error?)
}

struct RestCountriesAuthority: IRestCountriesAuthority {

    let baseUrl = "https://restcountries.eu"
    let getCountriesEndpoint: String = "/rest/v2/all"
    
    func buildCountriesRequest() -> (URLRequest?, Error?) {
        guard let url = URL(string: baseUrl + getCountriesEndpoint) else {
//            completionHandler(nil, Error())
            return (nil, nil)
        }
        let request = URLRequest(url: url)
        // Add auth header, change request method
        return (request, nil)
    }

}
