//
//  WalletTableViewController.swift
//  magma
//
//  Created by Justin Wilkin on 17/5/19.
//  Copyright © 2019 Code Candy. All rights reserved.
//

import UIKit

class WalletTableViewController: UITableViewController {
    private var data: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: Add data here
    }
    
    // Return the number of sections in our table
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Return the amount of items we have in our table's data
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    // Create our cell for our table
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // If we can reuse a cell use it
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CellRecycler") as? WalletTableViewCell {
            // TODO: Create card view here
            
            return cell
        }
        
        // Our reuse cell returned null so create blank cell
        return UITableViewCell()
    }
    
    // Handle selection of our table view cell
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
