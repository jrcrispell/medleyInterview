//
//  ViewController.swift
//  OmicronWeather
//
//  Created by Jason Crispell on 3/12/20.
//  Copyright © 2020 Jason Crispell. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, IBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        installConstraints()
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = UIColor.white
    }

    /**
     Empty implementation in this class, should be used by subclasses to add constraints
     */
    internal func installConstraints() {
        
    }

}

