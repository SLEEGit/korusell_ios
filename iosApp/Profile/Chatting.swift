//
//  Info.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/12/21.
//

import SwiftUI
import FirebaseAuth

struct Chatting: View {
    @StateObject var messagesManager = MessagesManager()
    
    var body: some View {
        VStack {
            VStack {
                
                ScrollViewReader { proxy in
                    ScrollView {
                        ForEach(messagesManager.messages, id: \.id) { message in
                            MessageBubble(message: message)
                        }
                    }
                    .padding(.top, 10)
//                    .background(.white)
//                    .cornerRadius(30, corners: [.topLeft, .topRight]) // Custom cornerRadius modifier added in Extensions file
                    .onChange(of: messagesManager.lastMessageId) { id in
                        // When the lastMessageId changes, scroll to the bottom of the conversation
//                        withAnimation {
                            proxy.scrollTo(id, anchor: .bottom)
//                        }
                    }
                }
            }
//            .background(Color.gray)
            
            MessageField()
                .environmentObject(messagesManager)
        }
    }
}
