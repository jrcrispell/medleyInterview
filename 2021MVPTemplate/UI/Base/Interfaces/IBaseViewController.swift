//
//  IBaseViewController.swift
//  OmicronWeather
//
//  Created by Jason Crispell on 3/13/20.
//  Copyright © 2020 Jason Crispell. All rights reserved.
//

import UIKit

/**
 The interface that all ViewController subclasses will implement
 Provides an initial point for installing constraints in code
 */

protocol IBaseViewController where Self: UIViewController {
    
    /**
     Adds constraints to themain view's subviews. The base implementation should call this in viewDidLoad()
     */
    func installConstraints()
    
    
}
