//
//  INetworkManager.swift
//  OmicronWeather
//
//  Created by Jason Crispell on 3/13/20.
//  Copyright © 2020 Jason Crispell. All rights reserved.
//

import Foundation

protocol INetworkManager {
    
    init(baseURL: String)
}

typealias NetworkManagerGetObjectCompletion = (_: Data?, _ : Error?) -> Void
typealias JSONDictionary = [String: Any]

enum NetworkManagerError: Int {
    case malformedURL = 1000, badData, unauthorized, resourceNotFound, otherError
    
    var domain: String {
        return "NetworkManagerError"
    }
    
    func error() -> NSError {
        return NSError(domain: domain, code: rawValue)
    }
}
