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
    func setup(_ transaction: Transaction) {
        locationLabel.text = "edit this later"
        priceLabel.text = "edit this later"
        dateLabel.text = "edit this later"
    }

}
