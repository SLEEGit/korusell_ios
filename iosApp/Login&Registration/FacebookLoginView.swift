//
//  FacebookLoginView.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/12/24.
//

import SwiftUI
import FBSDKLoginKit
import Firebase

struct FaceBookLoginView: UIViewRepresentable {
    
    
    func makeCoordinator() -> FaceBookLoginView.Coordinator {
        return FaceBookLoginView.Coordinator()
    }
    
    class Coordinator: NSObject, LoginButtonDelegate {
        
        func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
            if let error = error {
              print(error.localizedDescription)
              return
            }
            
            let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
            Auth.auth().signIn(with: credential) { (authResult, error) in
              if let error = error {
                  let errorText: String  = error.localizedDescription
                  Pref.registerCompletion = errorText
                  return
              }
                if let user = authResult?.user {
                    DB().getUser(uid: user.uid) { gotUser in
                        if user.uid != gotUser.uid {
                            DB().createUserInDB(user: user) {
                                Pref.registerCompletion = "success"
                            }
                        }
                    }

                }
                Pref.isLoggedIn = true
                Pref.userDefault.set(true, forKey: "usersignedin")
                Pref.userDefault.synchronize()
                Pref.registerCompletion = "success"
                print("SIGNED IN   \(String(describing: Auth.auth().currentUser?.email))")
                print("SUCCESS!")
            }
        }

        func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
            try! Auth.auth().signOut()
        }
    }
    
    func makeUIView(context: UIViewRepresentableContext<FaceBookLoginView>) -> FBLoginButton {
        let view = FBLoginButton()
        view.permissions = ["email"]
        view.delegate = context.coordinator
        return view
    }
    
    func updateUIView(_ uiView: FBLoginButton, context: UIViewRepresentableContext<FaceBookLoginView>) { }
}
