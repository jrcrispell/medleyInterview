//
//  IBaseNavigationPresenter.swift
//  OmicronWeather
//
//  Created by Jason Crispell on 3/13/20.
//  Copyright © 2020 Jason Crispell. All rights reserved.
//

import Foundation

protocol IBaseNavigationPresenter: AnyObject {
    
    /**
     Creates the Root View Controller
     */
    func createRootView() -> IRootViewController

}
