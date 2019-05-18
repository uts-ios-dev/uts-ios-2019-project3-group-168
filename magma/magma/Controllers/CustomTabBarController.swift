//
//  CustomTabController.swift
//  magma
//
//  Created by Justin Wilkin on 16/5/19.
//  Copyright © 2019 Code Candy. All rights reserved.
//

import SwipeableTabBarController

class CustomTabBarController: SwipeableTabBarController {
    
    // MARK: - Setup
    // On loading the tab view set up the scrolling settings
    override func viewDidLoad() {
        // Side by side animates the tabs to move at the same speed
        swipeAnimatedTransitioning?.animationType = SwipeAnimationType.sideBySide
        
        // Is swiping enabled
        isSwipeEnabled = true
        
        // Cycle from end to start
        isCyclingEnabled = false
    }
}
