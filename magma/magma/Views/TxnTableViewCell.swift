//
//  TxnTableViewCell.swift
//  magma
//
//  Created by Justin Wilkin on 22/5/19.
//  Copyright © 2019 Code Candy. All rights reserved.
//

import UIKit

class TxnTableViewCell: UITableViewCell {
    
    // Temporary please remove
    @IBOutlet weak var txnLabel: UILabel!
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
        txnLabel.text = "\(transaction.getAmount()) \(transaction.getCurrency())"
    }

}
