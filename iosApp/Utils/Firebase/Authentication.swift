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
            
            DispatchQueue.main.async {
                Pref.userDefault.set(true, forKey: "usersignedin")
                Pref.userDefault.synchronize()
                completion()
                print("SIGNED IN   \(String(describing: Auth.auth().currentUser?.email))")
            }
        }
    }

    func signOut(completion: @escaping () -> Void) {
        do {
            print("SIGNED OUT   \(String(describing: Auth.auth().currentUser?.email))")
            try Auth.auth().signOut()
            Pref.userDefault.set(false, forKey: "usersignedin")
            Pref.userDefault.synchronize()
            print("SIGNED OUT   \(String(describing: Auth.auth().currentUser?.email))")
            completion()
        } catch {
                print("ERROR SIGN OUT")
        }
        

        
    }
    
    func signUp(email: String, password: String, completion: @escaping () -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else {
                print("НЕ УДАЛОСЬ ЗАРЕГИСТРИРОВАТЬСЯ")
                return
            }
            if let user = result?.user {
                DB().createUserInDB(user: user) {
                    completion()
                }
            }
        }
    }
}
        
