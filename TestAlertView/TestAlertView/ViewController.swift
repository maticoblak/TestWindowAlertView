//
//  ViewController.swift
//  TestAlertView
//
//  Created by Matic Oblak on 17/12/2019.
//  Copyright © 2019 Matic Oblak. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTap)))
    }
    
    @objc private func onTap() {
        AlertViewController.showMessage("This is a test dialog to show how alerts work")
    }
    
    


}

