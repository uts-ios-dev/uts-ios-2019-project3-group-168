//
//  WalletTableViewHeaderCell.swift
//  magma
//
//  Created by Justin Wilkin on 20/5/19.
//  Copyright © 2019 Code Candy. All rights reserved.
//

import UIKit

class WalletTableViewHeaderCell: UITableViewCell {

    @IBOutlet weak var headerLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    public func setup(_ title: String) {
        backgroundColor = UIColor.white
        headerLabel.text = title
    }
}
