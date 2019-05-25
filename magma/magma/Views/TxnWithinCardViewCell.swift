//
//  TxnWithinCardViewCell.swift
//  magma
//
//  Created by Rohit Maharjan on 24/5/19.
//  Copyright © 2019 Code Candy. All rights reserved.
//

import UIKit

class TxnWithinCardViewCell: UITableViewCell {

    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // Setup the custom cell for our view using a transaction object
    func setup(_ transaction: Transaction, _ card : Card) -> Bool {
        // checking if the card number matches the card number in transaction
        if card.getNumber() == transaction.getCard().getNumber() {
            locationLabel.text = "\(transaction.getLocation())"
            priceLabel.text = "\(transaction.getAmount()) \(transaction.getCurrency())"
            dateLabel.text = "\(transaction.getDate())"
            return true
        }
        return false
    }

}
