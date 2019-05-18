//
//  CardStyle.swift
//  magma
//
//  Created by Justin Wilkin on 18/5/19.
//  Copyright © 2019 Code Candy. All rights reserved.
//

import UIKit

struct CardStyle {
    // MARK: - Properties
    var backgroundLayer = CAGradientLayer()
    var detailsBackgroundLayer = CAGradientLayer()
    
    // MARK: - Constructors
    init () {
        // Set the default card colors
        backgroundLayer.colors = [UIColor.middleOrange.cgColor, UIColor.middleOrange.cgColor]
        backgroundLayer.startPoint = CGPoint(x: 0,y: 0)
        backgroundLayer.endPoint = CGPoint(x: 1,y: 1)
        
        detailsBackgroundLayer.colors = [UIColor.lightOrange.cgColor, UIColor.flatOrange.cgColor]
        detailsBackgroundLayer.startPoint = CGPoint(x: 0,y: 0)
        detailsBackgroundLayer.endPoint = CGPoint(x: 1,y: 1)
    }
}
