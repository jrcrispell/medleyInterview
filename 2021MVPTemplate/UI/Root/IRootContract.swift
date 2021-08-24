//
//  IRootContract.swift
//  2021MVPTemplate
//
//  Created by Jason Crispell on 8/17/21.
//

import Foundation

protocol IRootPresenter: IBasePresenter {
    
}

protocol IRootViewController: IBaseViewController {
    init(presenter: IRootPresenter)
}
