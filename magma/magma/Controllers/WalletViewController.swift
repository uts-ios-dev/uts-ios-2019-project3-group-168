//
//  WalletViewController.swift
//  magma
//
//  Created by Justin Wilkin on 15/5/19.
//  Copyright © 2019 Code Candy. All rights reserved.
//

import UIKit

class WalletViewController: UIViewController {
    let cardManager: CardManager = CardManager()
    
    // Do initial setup
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Load our cards into our wallet
        cardManager.loadCards()
        print("Card Number: \(cardManager.getCard(id: 1).getNumber())")
    }

}
