//
//  ViewController.swift
//  ContractGo
//
//  Created by Bhoomika on 20/06/20.
//  Copyright © 2020 Bhoomika. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        DatabaseQuery().createTableinDatabase()
        // Do any additional setup after loading the view.
    }

}

