//
//  WalletTableViewController.swift
//  magma
//
//  Created by Justin Wilkin on 17/5/19.
//  Copyright © 2019 Code Candy. All rights reserved.
//

import UIKit

class WalletTableViewController: UITableViewController {
    
    // MARK: - Setup
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.backgroundColor = UIColor.white
        
        // Load our cards into our wallet
        CardAPI.shared().loadCards({ (resultCode, message) in
            // If our server respons was successful get our cards
            switch resultCode {
            case Constants.SUCCESS:
                // On a success reload our data
                self.tableView.reloadData()
            case Constants.FAILURE:
                print(message)
            default:
                print("Code: \(resultCode) \(message)")
            }
            
        }, controller: self)
    }
    
    // MARK: - Table View Recycling
    // Return the number of sections in our table
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Return the amount of items we have in our table's data
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CardAPI.shared().getCards().count
    }
    
    // Create our cell for our table
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // If we can reuse a cell use it
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CellRecycler") as? WalletTableViewCell {
            // Populate the values of our card view (cell)
            let card = CardAPI.shared().getCards()[indexPath.row]
            // Set up our card view with the current card in our list
            cell.setup(card, controller: self)
            // Setup our click inside the card
            setupOnClick(view: cell.getCardView(), cardCell: cell)
            
            return cell
        }
        // Our reuse cell returned null so create blank cell
        return UITableViewCell()
    }
    
    // Create our header cell for our table
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as? WalletTableViewHeaderCell {
            // Populate the header cell
            cell.setup("Wallet")
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 90
    }
    
    // MARK: - User Input
    func setupOnClick(view: UIView, cardCell: WalletTableViewCell) {
        let gesture = CardTapGestureRecognizer(target: self, action: #selector(handleOnClick(_:)))
        gesture.card = cardCell.getCard()
        view.addGestureRecognizer(gesture)
    }
    
    // Handle our click event and give the user the option to pay or view card details
    @objc func handleOnClick(_ sender: CardTapGestureRecognizer) {
        let card = sender.card
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        // swiftlint:disable:next force_cast
        let viewController = storyBoard.instantiateViewController(withIdentifier: "cardTxns") as! CardTxnsTableViewController
        if (card != nil) {
            viewController.setCard(card!)
        }
        self.present(viewController, animated: true, completion: nil)
    }
}
