//
//  iosAppApp.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/11/28.
//

import SwiftUI
import Firebase

@main
struct iosAppApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
