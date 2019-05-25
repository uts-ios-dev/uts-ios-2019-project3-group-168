//
//  SettingsViewController.swift
//  magma
//
//  Created by Justin Wilkin on 16/5/19.
//  Copyright © 2019 Code Candy. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var enableTouchIdView: UIView!
    @IBOutlet weak var changeDetailView: UIView!
    @IBOutlet weak var logOutView: UIView!
    
    // MARK: - Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        enableTouchIdView.layer.borderWidth = 1
        enableTouchIdView.layer.borderColor = UIColor.white.cgColor
        
        changeDetailView.layer.borderWidth = 1
        changeDetailView.layer.borderColor = UIColor.white.cgColor
        
        logOutView.layer.borderWidth = 1
        logOutView.layer.borderColor = UIColor.white.cgColor
    }
    
}
