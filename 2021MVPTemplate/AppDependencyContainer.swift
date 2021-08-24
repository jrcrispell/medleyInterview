//
//  AppDependencyContainer.swift
//  OmicronWeather
//
//  Created by Jason Crispell on 3/13/20.
//  Copyright © 2020 Jason Crispell. All rights reserved.
//

import Foundation

class AppDependencyContainer: IAppDependencyContainer {
    
    private let networkManager = NetworkManager(baseURL: "https://restcountries.eu/")
    
    private lazy var dataManager: IDataManager = {
        return DataManager(networkManager: self.networkManager)
    }()
    
    internal lazy var baseNavigationController: IBaseNavigationController = {
        return BaseNavigationController(dataManager: self.dataManager)
    }()
}
