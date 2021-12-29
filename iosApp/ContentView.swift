//
//  ContentView.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/11/28.
//

import SwiftUI



struct ContentView: View {
    
    
    
    var body: some View {
        TabView {
            ServiceMenuView()
                .tabItem {
                    Image(systemName: "house")
                }
            MapView()
                .tabItem {
                    Image(systemName: "map")
                }
            CheckStatusView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                }
        }
        .onAppear {
            
//            Pref.userDefault.set(false, forKey: "usersignedin")
//            Pref.userDefault.synchronize()
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
    }
}

let person: Person = Person(_id: "ds", avatar: "avatar", name: "John Legend", username: "username", email: "email@email.com", phone: "010 0000 0000")
