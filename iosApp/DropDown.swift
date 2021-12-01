//
//  DropDown.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/11/29.
//

import Foundation
import SwiftUI

struct DropDownAction {
    
    var title: String
    var action: () -> ()
}

private struct DropDownButton: View {
    
    var actionModel: DropDownAction
    var select: (DropDownAction) -> ()
    
    var body: some View {
        Button(actionModel.title, action: {
            self.select(self.actionModel) })
    }
    
}

private struct DropDownMenu: View {
    
    var menuActions: [DropDownAction]
    var select: (DropDownAction) -> ()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ForEach(menuActions, id: \.title) {
                DropDownButton(actionModel: $0, select: self.select)
            }
        }
        .foregroundColor(.white)
        .padding(.all, 10)
        .background(Color(.black))
        .cornerRadius(10)
        .shadow(radius: 7)
    }

}

struct DropDownHeader: View {
    
    var title: String
    var action: () -> ()
    var expand: Bool
    
    var body: some View {
        Button(action: action, label: {
            HStack {
                Text(title + " ")
                Image(systemName: "chevron.\(expand ? "up" : "down")")
            }
            .padding(.all, 10)
        })
            .foregroundColor(.white)
            .background(Color(.black))
            .cornerRadius(10)
            .shadow(radius: 10)
    }
    
}

struct DemoView: View {
//    let actions: [DropDownAction] = [.init(title: "one", action: {}),
//                                     .init(title: "two", action: {}),
//                                     .init(title: "three", action: {}),
//    ]
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 100, height: 20)
                .cornerRadius(20)
            DropDownHeader(title: "Категории", action: {  }, expand: false)
        }
    }
    
}
