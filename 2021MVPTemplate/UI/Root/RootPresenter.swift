//
//  RootPresenter.swift
//  2021MVPTemplate
//
//  Created by Jason Crispell on 8/17/21.
//

import UIKit

class RootPresenter: BasePresenter, IRootPresenter {
    
    private weak var rootView: IRootViewController? {
        return self.view as? IRootViewController
    }
    
    required init(dataManager: IDataManager) {
        super.init(dataManager: dataManager)
    }
}
