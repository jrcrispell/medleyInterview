//
//  BaseNavigationPresenter.swift
//  OmicronWeather
//
//  Created by Jason Crispell on 3/13/20.
//  Copyright © 2020 Jason Crispell. All rights reserved.
//

import UIKit

class BaseNavigationPresenter: IBaseNavigationPresenter {

    internal let dataManager: IDataManager
    
    required init(dataManager: IDataManager) {
        self.dataManager = dataManager
    }
    
    // MARK: IViewControllerFactory implementation
    func createRootView() -> IRootViewController {
        let presenter = RootPresenter(dataManager: dataManager)
        let viewController = RootViewController(presenter: presenter)
        return viewController
    }
    
}
