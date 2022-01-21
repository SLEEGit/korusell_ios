//
//  ChattingAdmin.swift
//  iosApp
//
//  Created by Sergey Lee on 2022/01/21.
//

import SwiftUI


struct ChattingAdmin: View {
    var body: some View {
        Spacer()
        MessageFieldAdmin()
        Spacer()
    }
}

struct MessageFieldAdmin: View {
    @State private var message = ""
    @State private var uid = ""

    var body: some View {
        VStack {
            CustomTextField(placeholder: Text("UID"), text: $uid)
                .frame(height: 30)
                .padding(.horizontal)
                .padding(.vertical, 10)
                .background(Color.gray)
                .cornerRadius(30)
                .padding(5)
            HStack {
                // Custom text field created below

                CustomTextField(placeholder: Text("Сообщение..."), text: $message)
                    .frame(height: 30)
    //                .disableAutocorrection(true)

                Button {
                    MessagesManager().sendMessageFromAdmin(text: message, userUID: uid)
                    message = ""
                } label: {
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(.white)
                        .padding(3)
                        .background(Color.blue)
                        .cornerRadius(50)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            .background(Color.gray)
            .cornerRadius(30)
            .padding(5)
        }
    }
}
