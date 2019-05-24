//
//  TxnTableViewController.swift
//  magma
//
//  Created by Justin Wilkin on 22/5/19.
//  Copyright © 2019 Code Candy. All rights reserved.
//

import Foundation
import UIKit

class TxnTableViewController: UITableViewController {
    private var transactions: [Transaction] = []
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.backgroundColor = UIColor.white
        self.tableView.separatorStyle = .singleLine // separator to be used as a single line
        // Load our transactions
        TransactionAPI.shared().getTransactions { (resultCode, transactions, message)  in
            if (resultCode == Constants.SUCCESS) {
                self.transactions = transactions
                print(transactions)
                self.tableView.reloadData()
            } else {
                print(message)
            }
        }
    }
    
    // MARK: - Table View Recycling
    // Return the number of sections in our table
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Return the amount of items we have in our table's data
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    // Create our cell for our table
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // If we can reuse a cell use it
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CellRecycler") as? TxnTableViewCell {
            // Populate the values of our card view (cell)
            let transaction = transactions[indexPath.row]
            cell.setup(transaction)
            
            return cell
        }
        // Our reuse cell returned null so create blank cell
        return UITableViewCell()
    }
    
    // Create our header cell for our table
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as? WalletTableViewHeaderCell {
            // Populate the header cell
            cell.setup("Transactions")
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 90
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    // MARK: - User Input
    // Handle selection of our table view cell
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "transactionOfCard", sender: nil)
    }

}
