//
//  BaseNavigationController.swift
//  OmicronWeather
//
//  Created by Jason Crispell on 3/12/20.
//  Copyright © 2020 Jason Crispell. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController, IBaseNavigationController, IRouter {

    internal var dataManager: IDataManager
    
    internal lazy var presenter: IBaseNavigationPresenter = {
        BaseNavigationPresenter(dataManager: self.dataManager)
    }()
    
    required init(dataManager: IDataManager) {
        self.dataManager = dataManager
        super.init(nibName: nil, bundle: nil)
        navigateToRootView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.isHidden = true
    }
    
    override func loadView() {
        super.loadView()
    }
    
    func showSpinner() {
        //TODO
    }
    
    func hideSpinner() {
        //TODO
        
    }
    
    func navigateToRootView() {
        let rootView = presenter.createRootView()
        pushViewController(rootView, animated: true)
    }
    

}
