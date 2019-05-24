//
//  TxnWithinCardViewController.swift
//  magma
//
//  Created by Rohit Maharjan on 24/5/19.
//  Copyright © 2019 Code Candy. All rights reserved.
//

import UIKit

// This is the view controller for the transaction that is to be displayed after clicking on the card
class TxnWithinCardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private var transactions: [Transaction] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Need to do : Add cells to the table
        if let cell = tableView.dequeueReusableCell(withIdentifier: "recycled") as? TxnWithinCardViewCell {
            // Populate the values of our card view (cell)
            let transaction = transactions[indexPath.row]
            cell.setup(transaction)
            
            return cell
        }
        // Our reuse cell returned null so create blank cell
        return UITableViewCell()    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
