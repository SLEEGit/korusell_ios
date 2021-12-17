//
//  CheckStatusView.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/12/15.
//

import SwiftUI
import FirebaseAuth

struct CheckStatusView : View {
    
    @StateObject var logging = Logging()
    @State var isLoggedIn: Bool = false
    @State var user = Auth.auth().currentUser
    
    @ViewBuilder
    var body: some View {
        //                if Pref.userDefault.bool(forKey: "usersignedin") {
        //                    logging.isSignedIn = true
        //                }
        if !logging.isSignedIn && !Pref.userDefault.bool(forKey: "usersignedin") {
            LoginView(logging: logging)
        } else {
            ProfileView(logging: logging, email: user!.email!, uid: user!.uid, displayName: user?.displayName ?? "no display name")
        }
    }
}

class Logging: ObservableObject {
    @Published var isSignedIn: Bool = false
}
