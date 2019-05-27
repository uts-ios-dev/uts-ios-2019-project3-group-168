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
        UIApplication.shared.statusBarView?.backgroundColor = UIColor.white
        // Get all of our transactions for our card
        TransactionAPI.shared().getTransactionsByCard(card: card!, { (resultCode, transactions, message)  in
            if (resultCode == Constants.SUCCESS) {
                self.transactions = transactions
                self.tableView.reloadData()
            } else {
                print(message)
            }
        })
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (transactions.count == 0) {
            // Return 1 cell so we can use it to show there are no transaction
            return 1
        }
        return transactions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // If we can reuse a cell use it
        if (transactions.count > 0) {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "CellRecycler") as? TxnTableViewCell {
                // Populate the values of our card view (cell)
                let transaction = transactions[indexPath.row]
                cell.setup(transaction, isWithinCard: true)
                
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
        if let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCard") as? WalletTableViewCell {
            // Populate the header cell
            cell.setup(card, controller: self)
            cell.backgroundColor = UIColor.white
            
            setupButtons(cell)
            
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 325
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    public func setCard(_ card: Card) {
        self.card = card
    }
    
    public func setTransaction(_ transaction: [Transaction]) {
        self.transactions = transaction
    }
    
    // Setup pay button and back button
    private func setupButtons(_ cell: UITableViewCell) {
        let payView: UIImageView = UIImageView(image: UIImage(named: "pay_icon"))
        payView.isUserInteractionEnabled = true
        payView.frame.size.width = payView.frame.width / 4
        payView.frame.size.height = payView.frame.height / 4
        payView.frame.origin.y = cell.frame.height
        payView.frame.origin.x = cell.frame.width / 2 - payView.frame.width / 2 + 50
        setupOnClick(payView, function: Constants.FUNCTION_PAY)
        cell.addSubview(payView)
        
        let backView: UIImageView = UIImageView(image: UIImage(named: "back_icon"))
        backView.isUserInteractionEnabled = true
        backView.alpha = 0.8
        backView.frame.size.width = backView.frame.width / 4 * 3
        backView.frame.size.height = backView.frame.height / 4 * 3
        backView.frame.origin.y = cell.frame.height
        backView.frame.origin.x = cell.frame.width / 2 - backView.frame.width / 2 - 50
        setupOnClick(backView, function: Constants.FUNCTION_BACK)
        cell.addSubview(backView)
    }
    
    // MARK: - User Input
    func setupOnClick(_ view: UIView, function: String) {
        let gesture = CardTapGestureRecognizer(target: self, action: #selector(self.handleOnClick(_:)))
        gesture.function = function
        view.addGestureRecognizer(gesture)
    }
    
    // Handle our click event and give the user the option to pay or view card details
    @objc func handleOnClick(_ sender: CardTapGestureRecognizer) {
        if (sender.function == Constants.FUNCTION_BACK) {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyBoard.instantiateViewController(withIdentifier: "homeViewController")
            self.present(viewController, animated: true, completion: nil)
        } else if (sender.function == Constants.FUNCTION_PAY) {
            // TODO: Handle pay
            print("Paying")
        }
    }
}
