//
//  ViewController.swift
//  2021MVPTemplate
//
//  Created by Jason Crispell on 8/17/21.
//

import UIKit

class RootViewController: BaseViewController, IRootViewController {

    private let presenter: IRootPresenter

    required init(presenter: IRootPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        presenter.connectToView(view: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewReady()
    }


}

