//
//  Util.swift
//  magma
//
//  Created by Justin Wilkin on 17/5/19.
//  Copyright © 2019 Code Candy. All rights reserved.
//

import UIKit

final class Util {
    
    // MARK: - Get Random Numbers
    public static func getRandomIntInclusive(start: Int, end: Int) -> Int {
        return Int.random(in: start ... end)
    }
    
    public static func getRandomIntExcludingEnd(start: Int, end: Int) -> Int {
        return Int.random(in: start ..< end)
    }
    
    public static func getRandomIntExcludingStart(start: Int, end: Int) -> Int {
        return Int.random(in: start + 1 ... end)
    }
    
    public static func getRandomIntExcludingStartEnd(start: Int, end: Int) -> Int {
        return Int.random(in: start + 1 ..< end)
    }
    
    public static func getRandomDouble(start: Double, end: Double) -> Double {
        return Double.random(in: start ..< end)
    }
    
    // MARK: - User Defaults Utilities
    // Get a string from User Defaults
    public static func getUserDefaultsString(accessKey: String) -> String? {
        let preferences = UserDefaults.standard
        return preferences.string(forKey: accessKey)
    }
    
    // Get an Int from User Defaults
    public static func getUserDefaultsInt(accessKey: String) -> Int? {
        let preferences = UserDefaults.standard
        return preferences.integer(forKey: accessKey)
    }
    
    // Get any object from User Defaults (can be of type string, int, double, bool, etc.)
    public static func getUserDefaultsObject(accessKey: String) -> Any? {
        let preferences = UserDefaults.standard
        return preferences.object(forKey: accessKey)
    }
    
    // Set an object in User Defaults (can be of type string, int, double, bool, etc.)
    public static func setUserDefaultsObject(accessKey: String, value: Any) -> Bool {
        let preferences = UserDefaults.standard
        preferences.set(value, forKey: accessKey)
        return preferences.synchronize()
    }
    
    // Detect if we are using an iPhone with the Top Notch (iPhone X, XS, XS Max, etc.)
    public static func hasTopNotch() -> Bool {
        if #available(iOS 11.0, tvOS 11.0, *) {
            return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
        }
        return false
    }
}

// MARK: - Extensions
extension UITextField {
    func setLeftPadding(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPadding(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
