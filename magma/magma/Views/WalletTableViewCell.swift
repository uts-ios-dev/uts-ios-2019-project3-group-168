//
//  WalletTableViewCell.swift
//  magma
//
//  Created by Justin Wilkin on 17/5/19.
//  Copyright © 2019 Code Candy. All rights reserved.
//

import UIKit

class WalletTableViewCell: UITableViewCell {
    // MARK: - Properties
    @IBOutlet weak var cardView: UIView!
    private var card: Card!
    private let paddingLeft: CGFloat = 20
    private let paddingTop: CGFloat = 20
    private let fontSize: CGFloat = 25
    private let detailsFontSize: CGFloat = 18
    private let detailsSubtitleFontSize: CGFloat = 12
    private let detailsSubtitlePaddingTop: CGFloat = 10
    private let detailsPaddingTop: CGFloat = 20
    private let cornerRadius: CGFloat = 10
    private var shadowLayer: CAShapeLayer?
    private var controller: UITableViewController!
    private var cardNumberLabel: UILabel!
    private var detailsView: UIView!
    
    // MARK: -
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Cell Manipulation
    // Setup our card with its styling and details
    public func setup(_ card: Card, controller: UITableViewController) {
        // Set a reference to our view controller
        self.controller = controller
        
        // Set our card as a reference object
        self.card = card
        
        // Setup our Card View
        cardView.backgroundColor = UIColor.clear
        cardView.clipsToBounds = false
        card.getStyle().backgroundLayer.frame = cardView.bounds
        card.getStyle().backgroundLayer.cornerRadius = 10
        cardView.layer.addSublayer(card.getStyle().backgroundLayer)
        
        // Add a drop shadow to the card
        if (shadowLayer == nil) {
            shadowLayer = CAShapeLayer()
            
            shadowLayer!.path = UIBezierPath(roundedRect: cardView.bounds, cornerRadius: cornerRadius).cgPath
            
            shadowLayer!.shadowColor = UIColor.black.cgColor
            shadowLayer!.shadowPath = shadowLayer!.path
            shadowLayer!.shadowOffset = CGSize(width: 0.0, height: 5.0)
            shadowLayer!.shadowOpacity = 0.2
            shadowLayer!.shadowRadius = 3
            
            cardView.layer.insertSublayer(shadowLayer!, at: 0)
        }
        
        // Add our logo to the card
        let logoView = addLogo()
        cardView.addSubview(logoView)
        
        // Add our card number to the card
        cardNumberLabel = addCardNumber(card, logoView)
        cardView.addSubview(cardNumberLabel)
        
        // Add our EMV Chip for style
        let emvChipView = addEmvChip()
        cardView.addSubview(emvChipView)
        
        // Add our details view to our card
        detailsView = addDetails(card)
        cardView.addSubview(detailsView)
    }
    
    // Add the card logo to our card
    func addLogo() -> UILabel {
        let view = UILabel(frame: CGRect(x: 20, y: 20, width: 0, height: 0))
        view.text = Constants.APPLICATION_TITLE
        view.font = view.font.withSize(fontSize)
        view.textColor = UIColor.white
        view.frame.size.width = view.intrinsicContentSize.width
        view.frame.size.height = view.intrinsicContentSize.height
        
        return view
    }
    
    // Add our card number to our card
    func addCardNumber(_ card: Card, _ logoView: UILabel) -> UILabel {
        let label = UILabel(frame: CGRect(x: paddingLeft, y: logoView.frame.origin.y + 40, width: 0, height: 0))
        label.text = card.getNumber()
        label.font = label.font.withSize(fontSize)
        label.textColor = UIColor.white
        label.frame.size.width = label.intrinsicContentSize.width
        label.frame.size.height = label.intrinsicContentSize.height
        
        return label
    }

    // Add our emv chip to the card
    func addEmvChip() -> UIView {
        let view = UIImageView(image: UIImage(named: "emv_chip"))
        view.frame.origin.x = cardView.frame.origin.x + CGFloat(cardView.frame.width - view.frame.width * 2)
        view.frame.origin.y = cardView.frame.origin.y + 25
        
        return view
    }
    
    // Setup our details view
    func addDetails(_ card: Card) -> UIView {
        // Set our details view up
        let detailsViewHeight: CGFloat = 65
        let detailsViewPositionY = CGFloat(cardView.frame.height) - detailsViewHeight
        let detailsView = UIView(frame: CGRect(x: 0, y: detailsViewPositionY, width: cardView.frame.width, height: detailsViewHeight))
        card.getStyle().detailsBackgroundLayer.frame = detailsView.bounds
        detailsView.layer.addSublayer(card.getStyle().detailsBackgroundLayer)
        
        // Add the card holder name title to the card
        let cardNameTitle = UILabel(frame: CGRect(x: paddingLeft, y: detailsSubtitlePaddingTop, width: 0, height: 0))
        cardNameTitle.text = Constants.CARD_HOLDER_NAME_TITLE
        cardNameTitle.font = cardNameTitle.font.withSize(detailsSubtitleFontSize)
        cardNameTitle.textColor = UIColor.white
        cardNameTitle.frame.size.width = cardNameTitle.intrinsicContentSize.width
        cardNameTitle.frame.size.height = cardNameTitle.intrinsicContentSize.height
        detailsView.addSubview(cardNameTitle)
        
        // add our card holder name to the card
        let cardName = UILabel(frame: CGRect(x: paddingLeft, y: cardNameTitle.frame.origin.y + detailsPaddingTop, width: 0, height: 0))
        cardName.text = card.getName()
        cardName.font = cardName.font.withSize(detailsFontSize)
        cardName.textColor = UIColor.white
        cardName.frame.size.width = cardName.intrinsicContentSize.width
        cardName.frame.size.height = cardName.intrinsicContentSize.height
        detailsView.addSubview(cardName)
        
        // Round our details view with bottom corners to match our parent view
        let roundedDetailsMask = CAShapeLayer()
        roundedDetailsMask.bounds = detailsView.frame
        roundedDetailsMask.position = detailsView.center
        let radii = CGSize(width: cornerRadius, height: cornerRadius)
        let path = UIBezierPath(roundedRect: detailsView.bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: radii).cgPath
        roundedDetailsMask.path = path
        detailsView.layer.mask = roundedDetailsMask
        
        return detailsView
    }
    
    // Return our cardview to our controller for handling touch events
    public func getCardView() -> UIView {
        return cardView
    }
    
    // Return our card to the controller
    public func getCard() -> Card {
        return card
    }
    
    // Show the details used to pay
    public func showPayCard() {
        // Run the ui on the main thread otherwise we cannot update the ui
        DispatchQueue.main.async {
            // Set our number to be unmasked
            self.cardNumberLabel.text = self.card.getUnMaskedNumber()
            self.cardNumberLabel.frame.size.width = self.cardNumberLabel.intrinsicContentSize.width
            self.cardNumberLabel.frame.size.height = self.cardNumberLabel.intrinsicContentSize.height
            self.cardNumberLabel.font =  self.cardNumberLabel.font.withSize(self.fontSize - 2)
            
            // Add our expiry and expiry title to the details view
            let rect = CGRect(x: self.detailsView.frame.width - self.paddingLeft * 4, y: self.detailsSubtitlePaddingTop, width: 0, height: 0)
            let expiryTitle = UILabel(frame: rect)
            expiryTitle.text = Constants.CARD_EXPIRY_TITLE
            expiryTitle.font = expiryTitle.font.withSize(self.detailsSubtitleFontSize)
            expiryTitle.textColor = UIColor.white
            expiryTitle.textAlignment = .right
            expiryTitle.frame.size.width = expiryTitle.intrinsicContentSize.width
            expiryTitle.frame.size.height = expiryTitle.intrinsicContentSize.height
            self.detailsView.addSubview(expiryTitle)
            
            // Add the expiry to the card
            let xPos = self.detailsView.frame.width - self.paddingLeft * 4
            let expiryRect = CGRect(x: xPos, y: expiryTitle.frame.origin.y + self.detailsPaddingTop, width: 0, height: 0)
            let expiryLabel = UILabel(frame: expiryRect)
            expiryLabel.text = self.card.getExpiry()
            expiryLabel.font = expiryLabel.font.withSize(self.detailsFontSize)
            expiryLabel.textColor = UIColor.white
            expiryLabel.textAlignment = .right
            expiryLabel.frame.size.width = expiryLabel.intrinsicContentSize.width
            expiryLabel.frame.size.height = expiryLabel.intrinsicContentSize.height
            self.detailsView.addSubview(expiryLabel)
        }
    }
}
