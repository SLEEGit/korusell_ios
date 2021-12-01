//
//  MenuView.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/11/30.
//

import SwiftUI

struct MenuView: View {
    @ObservedObject var fetcher = DataFetcher()
    var body: some View {
        NavigationView {
            List(fetcher.menuItem, children: \.children){ item in
                ZStack {
                    NavigationLink(destination: Text(item.name)) {}
                    .opacity(0.0)
                    .buttonStyle(PlainButtonStyle())
                    HStack{
                        Text(item.image)
                            .font(.title)
                        Text(item.name)
                        Spacer()
                    }
                }
            }.navigationTitle("KORYOSARAM")
        }
    }
}


struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
