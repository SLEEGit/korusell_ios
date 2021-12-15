//
//  Authentication.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/12/15.
//

import Foundation
import FirebaseAuth

class Authentication {
    func signIn(email: String, password: String, completion: @escaping () -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else {
                print("НЕ УДАЛОСЬ АУТЕНТИФИЦИРОВАТЬСЯ")
                return
            }
            completion()
            Pref.userDefault.set(true, forKey: "usersignedin")
            Pref.userDefault.synchronize()
        }
    }

    func signUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else {
                return
            }
        }
        
        //Success
    }
}
        
