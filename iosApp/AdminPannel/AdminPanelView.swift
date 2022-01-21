//
//  AdminPanelView.swift
//  iosApp
//
//  Created by Sergey Lee on 2022/01/10.
//

import SwiftUI

struct AdminPanelView: View {
    var body: some View {
        Form {
            NavigationLink(destination: AddBusinessView()) {
                Text("Add business")
                    .font(.title)
            }
            NavigationLink(destination: AddAdvView()) {
                Text("Add advertisement")
                    .font(.title)
            }
            NavigationLink(destination: ChattingAdmin()) {
                HStack {
                    Text("Chatting")
                        .font(.title)
                }
            }
        }
    }
}

struct AdminPanelView_Previews: PreviewProvider {
    static var previews: some View {
        AdminPanelView()
    }
}
