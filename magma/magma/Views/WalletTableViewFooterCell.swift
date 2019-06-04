//
//  WalletTableViewFooterCell.swift
//  magma
//
//  Created by Justin Wilkin on 4/6/19.
//  Copyright © 2019 Code Candy. All rights reserved.
//

import UIKit

class WalletTableViewFooterCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func setup() {
        backgroundColor = UIColor.white
        let newCardButton = addImage()
        addSubview(newCardButton)
        
        let newLabel = newCardLabel()
        addSubview(newLabel)
    }
    
    // Add the card logo to our card
    func addImage() -> UIImageView {
        let view = UIImageView(image: UIImage(named: "new_card"))
        view.frame.size.width = 70
        view.frame.size.height = 70
        view.frame.origin.x = self.frame.width / 2 - view.frame.width / 2
        view.frame.origin.y = self.frame.height / 2 + 20
        
        return view
    }
    
    func newCardLabel() -> UILabel {
        let label = UILabel(frame: CGRect(x: frame.width / 2, y: frame.height / 2 + 105, width: 0, height: 0))
        label.text = Constants.NEW_CARD
        label.font = label.font.withSize(22)
        label.textAlignment = .center
        label.textColor = UIColor.flatBlack
        label.frame.size.width = label.intrinsicContentSize.width
        label.frame.size.height = label.intrinsicContentSize.height
        label.frame.origin.x = frame.width / 2 - label.frame.width / 2
        
        return label
    }
}
