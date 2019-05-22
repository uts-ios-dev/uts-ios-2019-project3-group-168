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
        
    @IBOutlet weak var cellView: UIView!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
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
        
        priceLabel.text = "\(transaction.getAmount()) \(transaction.getCurrency())"
        txnLabel.text = "\(transaction.getCard().getNumber())"
        dateLabel.text = "\(transaction.getDate())"
        locationLabel.text = "\(transaction.getLocation())"
    }
}
