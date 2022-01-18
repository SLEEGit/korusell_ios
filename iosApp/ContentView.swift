//
//  ContentView.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/11/28.
//

import SwiftUI

var globalAdv: [Adv] = []

struct ContentView: View {
    
    @State var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            ServiceMenuView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Услуги")
                }.tag(0)
            MapView()
                .tabItem {
                    Image(systemName: "map")
                    Text("Карта")
                }.tag(1)
//            AdvMenuView()
            HomeView()
                .tabItem {
                    VStack {
                        if selection == 2 {
                            Image("carrot")
                        } else {
                            Image("carrot_trans")
                        }
                    }
                    Text("Морковка")
                }.tag(2)
            CheckStatusView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Профиль")
                }.tag(3)
        }
        .onAppear {
            DB().getAdvs(category: "all") { (list) in
                globalAdv = list.sorted { $0.createdAt > $1.createdAt }
            }
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
