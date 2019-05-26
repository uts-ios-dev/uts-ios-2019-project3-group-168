//
//  TxnTableViewCell.swift
//  magma
//
//  Created by Justin Wilkin on 22/5/19.
//  Copyright © 2019 Code Candy. All rights reserved.
//

import UIKit

class TxnTableViewCell: UITableViewCell {
    
    @IBOutlet weak var transactionView: UIView!
    @IBOutlet weak var dateView: UIView!
    private var padding: CGFloat = 10
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // Setup the custom cell for our view using a transaction object
    func setup(_ transaction: Transaction, isWithinCard: Bool) {
        // Set our view size within our cell
        transactionView.frame.size = CGSize(width: transactionView.frame.width, height: 80)
        
        // Set the background of the Transaction view
        let backgroundLayer = CAGradientLayer()
        backgroundLayer.colors = [UIColor.middleGrey.cgColor, UIColor.white.cgColor]
        backgroundLayer.startPoint = CGPoint(x: 0, y: 0.5)
        backgroundLayer.endPoint = CGPoint(x: 1.3, y: 0.5)
        backgroundLayer.frame = transactionView.bounds
        transactionView.backgroundColor = UIColor.clear
        transactionView.clipsToBounds = false
        transactionView.layer.addSublayer(backgroundLayer)
        
        // Relayer our date view
        transactionView.bringSubviewToFront(dateView)
        
        // Clean our cell before setup (essential for dynamic recycling)
        dateView.subviews.forEach({
            $0.removeFromSuperview()
        })
        
        // Remove everything but our dateView
        transactionView.subviews.forEach {
            if ($0 != dateView) {
                $0.removeFromSuperview()
            }
        }
        
        // Add our date view
        let dateLabel = setupDateLabel(transaction)
        let monthLabel = setupMonthLabel(transaction)
        
        dateView.addSubview(dateLabel)
        dateView.addSubview(monthLabel)
        
        // Add our transaction details to the transactionView
        let locationLabel = setupLocationLabel(transaction)
        let cardNumberLabel = setupCardNumberLabel(transaction, isWithinCard)
        let amountLabel = setupAmountLabel(transaction)
        let currencyLabel = setupCurrencyLabel(transaction)
        
        transactionView.addSubview(cardNumberLabel)
        transactionView.addSubview(locationLabel)
        transactionView.addSubview(amountLabel)
        transactionView.addSubview(currencyLabel)
        
        // Add our red stripe on the left side
        let stripe = UIView(frame: CGRect(x: 0, y: 0, width: 3, height: transactionView.frame.height))
        stripe.backgroundColor = UIColor.flatRed
        transactionView.addSubview(stripe)
    }
    
    // Create our date label for the number
    private func setupDateLabel(_ transaction: Transaction) -> UILabel {
        let rect =  CGRect(x: dateView.frame.width / 2, y: dateView.frame.height / 2, width: dateView.frame.width, height: dateView.frame.height)
        let dateLabel = UILabel(frame: rect)
        let fullDate = transaction.getDate()
        dateLabel.text = String(fullDate.first!)
        dateLabel.font = UIFont.boldSystemFont(ofSize: 24)
        dateLabel.textColor = UIColor.flatBlack
        dateLabel.frame.size.width = dateLabel.intrinsicContentSize.width
        dateLabel.frame.size.height = dateLabel.intrinsicContentSize.height
        dateLabel.frame.origin.x = dateView.frame.width / 2 - dateLabel.frame.size.width / 2
        dateLabel.frame.origin.y = dateView.frame.height / 2 - dateLabel.frame.size.height / 4 * 3
        
        return dateLabel
    }

    // Create our month label for the date view
    private func setupMonthLabel(_ transaction: Transaction) -> UILabel {
        let rect =  CGRect(x: dateView.frame.width / 2, y: dateView.frame.height / 2, width: dateView.frame.width, height: dateView.frame.height)
        let label = UILabel(frame: rect)
        let fullDate = transaction.getDate()
        let month = fullDate.split(separator: " ")
        label.text = String(month[1])
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor.flatGrey
        label.frame.size.width = label.intrinsicContentSize.width
        label.frame.size.height = label.intrinsicContentSize.height
        label.frame.origin.x = dateView.frame.width / 2 - label.frame.size.width / 2
        label.frame.origin.y = dateView.frame.height / 2 + label.frame.size.height / 4
        
        return label
    }
    
    // Create our card number label for the transaction view
    private func setupLocationLabel(_ transaction: Transaction) -> UILabel {
        let rect =  CGRect(x: dateView.frame.width / 2, y: dateView.frame.height / 2, width: dateView.frame.width, height: dateView.frame.height)
        let label = UILabel(frame: rect)
        label.text = transaction.getReceiver()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.flatBlack
        label.frame.size.width = label.intrinsicContentSize.width
        label.frame.size.height = label.intrinsicContentSize.height
        label.frame.origin.x = dateView.frame.origin.x + dateView.frame.width + padding
        label.frame.origin.y = dateView.frame.origin.y
        
        return label
    }
    
    // Create our location label for the transaction view
    private func setupCardNumberLabel(_ transaction: Transaction, _ isWithinCard: Bool) -> UILabel {
        let rect =  CGRect(x: dateView.frame.width / 2, y: dateView.frame.height / 2, width: dateView.frame.width, height: dateView.frame.height)
        let label = UILabel(frame: rect)
        // Check to see if we already know the card number because we are looking at this from our card table
        if (isWithinCard) {
            label.text = transaction.getLocation()
        } else {
            label.text = transaction.getCard().getNumber()
        }
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.flatGrey
        label.frame.size.width = label.intrinsicContentSize.width
        label.frame.size.height = label.intrinsicContentSize.height
        label.frame.origin.x = dateView.frame.origin.x + dateView.frame.width + padding
        label.frame.origin.y = dateView.frame.origin.y + dateView.frame.height - label.frame.height
        
        return label
    }
    
    // Create our amount label for the transaction view
    private func setupAmountLabel(_ transaction: Transaction) -> UILabel {
        let rect =  CGRect(x: dateView.frame.width / 2, y: dateView.frame.height / 2, width: dateView.frame.width, height: dateView.frame.height)
        let label = UILabel(frame: rect)
        label.text = "-\(String.localizedStringWithFormat("%.2f", transaction.getAmount()))"
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.flatRed
        label.frame.size.width = label.intrinsicContentSize.width
        label.frame.size.height = label.intrinsicContentSize.height
        label.frame.origin.x = transactionView.frame.width - label.frame.size.width - padding
        label.frame.origin.y = dateView.frame.origin.y + padding / 2
        
        return label
    }
    
    // Create the currency label for the transaction view
    private func setupCurrencyLabel(_ transaction: Transaction) -> UILabel {
        let rect =  CGRect(x: dateView.frame.width / 2, y: dateView.frame.height / 2, width: dateView.frame.width, height: dateView.frame.height)
        let label = UILabel(frame: rect)
        label.text = transaction.getCurrency()
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.flatRed
        label.frame.size.width = label.intrinsicContentSize.width
        label.frame.size.height = label.intrinsicContentSize.height
        label.frame.origin.x = transactionView.frame.width - label.frame.size.width - padding
        label.frame.origin.y = dateView.frame.origin.y + label.frame.size.height + padding / 2
        
        return label
    }
}
