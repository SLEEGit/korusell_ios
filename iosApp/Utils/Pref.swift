//
//  Pref.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/12/15.
//

import Foundation

class Pref {
    static let userDefault = UserDefaults.standard
    static let launchBefore = UserDefaults.standard.bool(forKey: "usersignedin")
    static var registerCompletion: String = ""
    
    static var isLoggedIn: Bool = false
    
    static var any: Bool {
        get {
            return userDefault.bool(forKey: "kIsWatchedGuideVideo")
        }
        set(newValue) {
            userDefault.set(newValue, forKey: "kIsWatchedGuideVideo")
            userDefault.synchronize()
        }
    }
}
