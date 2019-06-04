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
        // Load our transactions
        TransactionAPI.shared().getTransactions { (resultCode, transactions, message)  in
            switch (resultCode) {
            case Constants.SUCCESS:
                self.transactions = transactions
                print(transactions)
                self.tableView.reloadData()
            case Constants.FAILURE:
                print(message)
            default:
                print("There was an error in our API call")
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
        if (transactions.count > 0) {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "CellRecycler") as? TxnTableViewCell {
                // Populate the values of our card view (cell)
                let transaction = transactions[indexPath.row]
                cell.setup(transaction, isWithinCard: false)
                
                return cell
            }
        }
        
        // There are no transactions so let the user know
        let noTransactionsCell = UITableViewCell()
        let rect =  CGRect(x: 0, y: 0, width: noTransactionsCell.frame.width, height: noTransactionsCell.frame.height)
        let label = UILabel(frame: rect)
        label.text = Constants.NO_TRANSACTIONS
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.flatBlack
        label.frame.size.width = label.intrinsicContentSize.width
        label.frame.size.height = label.intrinsicContentSize.height
        label.frame.origin.x = noTransactionsCell.frame.width - label.frame.size.width
        label.frame.origin.y = noTransactionsCell.frame.origin.y / 2
        
        noTransactionsCell.addSubview(label)
        
        return noTransactionsCell
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
        return 90
    }
    // MARK: - User Input
    // Handle selection of our table view cell
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
