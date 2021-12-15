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
}
