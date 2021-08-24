//
//  DataManager.swift
//  OmicronWeather
//
//  Created by Jason Crispell on 3/13/20.
//  Copyright © 2020 Jason Crispell. All rights reserved.
//

import Foundation

class DataManager: IDataManager {
    
    private(set) var networkManager: INetworkManager?
    
    required init(networkManager: INetworkManager) {
        self.networkManager = networkManager
    }
}
