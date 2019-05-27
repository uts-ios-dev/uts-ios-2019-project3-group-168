//
//  TransactionAPI.swift
//  magma
//
//  Created by Justin Wilkin on 22/5/19.
//  Copyright © 2019 Code Candy. All rights reserved.
//

import Alamofire
import SwiftyJSON

class TransactionAPI {
    // MARK: - Singleton
    private static var sharedAPI: TransactionAPI = {
        let transactionAPI = TransactionAPI()
        
        return transactionAPI
    }()
    
    // Setup our Transaction API to access our server
    private init() {
        
    }
    
    // Provide our singleton as an object to our application
    public static func shared() -> TransactionAPI {
        return sharedAPI
    }
    
    // MARK: - Transaction Managment
    public func getTransactions(_ callback: @escaping (Int, [Transaction], String) -> Void) {
        let server = Environment().configuration(PlistKey.ServerURL) + Endpoints.GET_TRANSACTIONS
        
        Alamofire.request(server, method: HTTPMethod.get, parameters: [Endpoints.Params.CARD_HOLDER_ID:Constants.userID]).responseJSON { response in
            if (response.result.isSuccess) {
                // Reload our local store of cards
                
                let data: JSON = JSON(response.result.value as Any)
                
                // Once we have received our card object from the server map it to a card locally
                let transactionJSONArray = data["transactions"]
                var transactionsArray: [Transaction] = []
                
                if (!transactionJSONArray.isEmpty) {
                    // For each card in our cardholders wallet create a local card
                    for (_, t) in transactionJSONArray {
                        let transaction = self.transactionFromJSON(t)
                        transactionsArray.append(transaction)
                    }
                    
                    // Stubbed out for testing without server
                    callback(Constants.SUCCESS, transactionsArray, "")
                }
            }
        }
        
        /*var transactionArray: [Transaction] = []
        
        for _ in 0...Util.getRandomIntInclusive(start: 1, end: 25) {
            let card: Card = Card()
            
            let amount = round(Util.getRandomDouble(start: 1, end: 1000) * 10) / 10
            let currency = "AUD"
            let location = "Syndey, Ultimo"
            let date = "2nd June 2019"
            let receiver = "KFC Ultimo"
            let transaction = Transaction(card: card, amount: amount, currency: currency, location: location, date: date, receiver: receiver)
            transactionArray.append(transaction)
        }
        
        callback(Constants.SUCCESS, transactionArray, "")*/
    }
    
    // Get transactions for an individual card
    public func getTransactionsByCard(card: Card, _ callback: @escaping (Int, [Transaction], String) -> Void) {
        let server = Environment().configuration(PlistKey.ServerURL) + Endpoints.GET_TRANSACTIONS
        
        Alamofire.request(server, method: HTTPMethod.get, parameters: [Endpoints.Params.CARD_HOLDER_ID:Constants.userID]).responseJSON { response in
            if (response.result.isSuccess) {
                // Reload our local store of cards
                
                let data: JSON = JSON(response.result.value as Any)
                
                // Once we have received our card object from the server map it to a card locally
                let transactionJSONArray = data["transactions"]
                var transactionsArray: [Transaction] = []
                
                if (!transactionJSONArray.isEmpty) {
                    // For each card in our cardholders wallet create a local card
                    for (_, t) in transactionJSONArray {
                        let transaction = self.transactionFromJSON(t)
                        if (transaction.getCard().getNumber() == card.getNumber()) {
                            transactionsArray.append(transaction)
                        }
                    }
                    
                    // Stubbed out for testing without server
                    callback(Constants.SUCCESS, transactionsArray, "")
                }
            }
        }
        
        /*var transactionArray: [Transaction] = []
        
        for _ in 0...Util.getRandomIntInclusive(start: 1, end: 25) {
            let card: Card = Card()
            
            let amount = round(Util.getRandomDouble(start: 1, end: 1000) * 10) / 10
            let currency = "AUD"
            let location = "Syndey, Ultimo"
            let date = "2nd June 2019"
            let receiver = "KFC Ultimo"
            let transaction = Transaction(card: card, amount: amount, currency: currency, location: location, date: date, receiver: receiver)
            transactionArray.append(transaction)
        }
        
        callback(Constants.SUCCESS, transactionArray, "")*/
    }
    
    private func transactionFromJSON(_ data: JSON) -> Transaction {
        let date = data["date"].stringValue
        let amount = data["amount"].doubleValue
        let currency = data["currency"].stringValue
        let receiver = data["receiver"].stringValue
        let location = data["location"].stringValue
        let cardJSON = data["card"]
        let card = Util.cardFromJSON(cardJSON)
        
        return Transaction(card: card, amount: amount, currency: currency, location: location, date: date, receiver: receiver)
    }
}
