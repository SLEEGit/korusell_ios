//
//  CheckStatusView.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/12/15.
//

import SwiftUI
import FirebaseAuth
import AppTrackingTransparency
import AdSupport

struct CheckStatusView : View {
    @ObservedObject var trackingHelper = ATTrackingHelper()
    @StateObject var logging = Logging()
    @State var isLoggedIn: Bool = false
    
    @ViewBuilder
    var body: some View {
        
        if !logging.isSignedIn && !Pref.userDefault.bool(forKey: "usersignedin") {
            LoginView(logging: logging)
                .onAppear { trackingHelper.requestAuth() }
        } else {
            ProfileView(logging: logging)
                .onAppear { trackingHelper.requestAuth() }
        }
    }
}


