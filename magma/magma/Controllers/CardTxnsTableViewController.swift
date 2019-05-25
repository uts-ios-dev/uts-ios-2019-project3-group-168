//
//  TxnWithinCardViewController.swift
//  magma
//
//  Created by Rohit Maharjan on 24/5/19.
//  Copyright © 2019 Code Candy. All rights reserved.
//

import UIKit

// This is the view controller for the transaction that is to be displayed after clicking on the card
class CardTxnsTableViewController: UITableViewController {
    private var transactions: [Transaction] = []
    private var card: Card!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Need to do : Add cells to the table
        if let cell = tableView.dequeueReusableCell(withIdentifier: "recycled") as? TxnWithinCardViewCell {
            // Populate the values of our card view (cell)
            let transaction = transactions[indexPath.row]
            
            // variable to check if there are transactions from that card.
            var isTransactionValid : Bool = false
            isTransactionValid = cell.setup(transaction, self.card!)
            
            // if there are valid transaction we return the cell, or else a blank cell is returned for now
            if isTransactionValid {
                return cell
            }
        }
        // Our reuse cell returned null so create blank cell
        return UITableViewCell()
    }
    
    // Create our header cell for our table
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCard") as? WalletTableViewCell {
            // Populate the header cell
            cell.setup(card, controller: self)
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 250
    }
    
    public func setCard(_ card: Card) {
        self.card = card
    }
    
    public func setTransaction(_ transaction: [Transaction]) {
        self.transactions = transaction
    }
}
