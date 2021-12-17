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
    let user = Auth.auth().currentUser
    
    @ViewBuilder
    var body: some View {
        
        if !logging.isSignedIn || user == nil {
            LoginView(logging: logging)
        } else {
            ProfileView(logging: logging, email: user!.email!, uid: user!.uid, displayName: user?.displayName ?? "no display name")
        }
    }
}

class Logging: ObservableObject {
    @Published var isSignedIn: Bool = false
}
