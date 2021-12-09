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
            Text("Map")
                .tabItem {
                    Image(systemName: "map")
                }
            Profile(person: person)
                .tabItem {
                    Image(systemName: "person.crop.circle")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
    }
}

let person: Person = Person(_id: "ds", avatar: "avatar", name: "John Legend", username: "username", email: "email@email.com", phone: "010 0000 0000")
