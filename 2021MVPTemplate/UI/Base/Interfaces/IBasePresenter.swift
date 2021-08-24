//
//  IBasePresenter.swift
//  OmicronWeather
//
//  Created by Jason Crispell on 3/13/20.
//  Copyright © 2020 Jason Crispell. All rights reserved.
//

import UIKit

/**
 Defines the base class for a Presenter that manages the data to be shown in a ViewController
 */
protocol IBasePresenter: AnyObject {
    
    /**
     Weak reference to the ViewController associated with this BasePresenter instance
     */
    var view: UIViewController? { get }
    
    /**
     Weak reference to the application's instance of a DataManager
     */
    
    var dataManager: IDataManager? { get }
    
    init(dataManager: IDataManager)
    
    /**
     Stores a reference to an instance of the coupled ViewController that should be updated for data changes
     */
    func connectToView(view: UIViewController)
    
    func viewReady()
}
