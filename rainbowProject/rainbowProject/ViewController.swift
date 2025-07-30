//
//  ViewController.swift
//  rainbowProject
//
//  Created by Student on 30/07/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
     
        // Do any additional setup after loading the view.
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarItem.badgeValue=nil
    }

}

