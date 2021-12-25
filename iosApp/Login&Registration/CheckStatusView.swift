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
    
    @ViewBuilder
    var body: some View {

        if !logging.isSignedIn && !Pref.userDefault.bool(forKey: "usersignedin") {
            LoginView(logging: logging)
        } else {
            ProfileView(logging: logging)
        }
    }
}


