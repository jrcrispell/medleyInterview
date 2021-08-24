//
//  IDataManager.swift
//  OmicronWeather
//
//  Created by Jason Crispell on 3/13/20.
//  Copyright © 2020 Jason Crispell. All rights reserved.
//

import Foundation

protocol IDataManager: class {
    
    init(networkManager: INetworkManager)
}

typealias DataManagerCompletion<T> = (_: T?, _ : Error?) -> Void
