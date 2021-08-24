//
//  BasePresenter.swift
//  OmicronWeather
//
//  Created by Jason Crispell on 3/13/20.
//  Copyright © 2020 Jason Crispell. All rights reserved.
//

import UIKit

class BasePresenter: IBasePresenter {

    internal weak var view: UIViewController?
    
    internal weak var dataManager: IDataManager?
    
    internal var router: IRouter? {
        self.view?.navigationController as? IRouter
    }
    
    required init(dataManager: IDataManager) {
        self.dataManager = dataManager
    }
    
    final func connectToView(view: UIViewController) {
        self.view = view
    }
    
    /**
     Overridden in subclasses once loadView() is called in ViewController
     */
    internal func viewReady() {
        
    }
}
