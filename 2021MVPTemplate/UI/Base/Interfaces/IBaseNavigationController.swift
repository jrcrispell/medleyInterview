//
//  IBaseNavigationController.swift
//  OmicronWeather
//
//  Created by Jason Crispell on 3/13/20.
//  Copyright © 2020 Jason Crispell. All rights reserved.
//

import Foundation

protocol IBaseNavigationController: BaseNavigationController {
    
    var dataManager: IDataManager { get }
    var presenter: IBaseNavigationPresenter { get }
    
    init(dataManager: IDataManager)
    
    /**
     Shows a loading spinner for async operations
     */
    func showSpinner()
    
    /**
     Hides the loading spinner
     */
    func hideSpinner()
}
