//
//  CheckStatusView.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/12/15.
//

import SwiftUI
import FirebaseAuth

struct CheckStatusView : View {
    
    @State var isLoggedIn: Bool = false
    
    var body: some View {
        
        let user = Auth.auth().currentUser
        
        if !isLoggedIn {
            LoginView(isLoggedIn: $isLoggedIn)
        } else {
            ProfileView(email: user!.email!, uid: user!.uid, displayName: user?.displayName ?? "no display name")
        }
    }
}

