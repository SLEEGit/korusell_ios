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
            MenuView()
                .tabItem {
                    Image(systemName: "house")
                }
            Text("View for adding adv")
                .tabItem {
                    Image(systemName: "plus.square")
                }
            Text("Personal Page")
                .tabItem {
                    Image(systemName: "person")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
