//
//  User.swift
//  magma
//
//  Created by Justin Wilkin on 17/5/19.
//  Copyright © 2019 Code Candy. All rights reserved.
//

class User {
    // MARK: - Properties
    private var firstName : String
    private var middleName : String?
    private var lastName : String
    private var email : String
    private var password : String

    // MARK: - Initalizer
    init (_ firstName : String,_ middleName : String? ,_ lastName : String, _ email : String, _ password : String) {
        self.firstName = firstName
        self.middleName = middleName
        self.lastName = lastName
        self.email = email
        self.password = password
    }
    
    // MARK: - getter
    func getFirstName () -> String {
        return self.firstName
    }
    
    func getMiddleName () -> String {
        return self.middleName!
    }
    
    func getLastName () -> String {
        return self.lastName
    }
    
    func getEmail () -> String {
        return self.email
    }
    
    func getPassword () -> String {
        return self.password
    }
    
    // MARK: - setter
    func setFirstName (_ firstName : String) {
        self.firstName = firstName
    }
    
    func setMiddleName (_ middleName : String) {
        self.middleName = middleName
    }
    
    func setLastName (_ lastName : String) {
        self.lastName = lastName
    }
    
    func setEmail (_ email : String) {
        self.email = email
    }
    
    func setPassword (_ password : String) {
        self.password = password
    }
}
