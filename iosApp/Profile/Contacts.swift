//
//  Contacts.swift
//  iosApp
//
//  Created by Sergey Lee on 2022/03/12.
//

import SwiftUI
import FirebaseAuth

struct Contacts: View {
    var body: some View {
        VStack(alignment: .leading, spacing:30) {
            Spacer().frame(height: 30)
            Link(destination: URL(string: "https://t.me/korusell_bot")!, label: {
                HStack(spacing: 10) {
                    Image("telegram")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                    Text("Telegram/@korusell_bot")
                }
            })
                    Link(destination: URL(string: "https://www.instagram.com/korusell")!, label: {
                        HStack(spacing: 10) {
                            Image("instagram")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                            Text("Instagram/@korusell")
                        }
                    })
            Link(destination: URL(string: "mailto:ceo@korusell.com")!, label: {
                HStack(spacing: 10) {
                    Image("email")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                    Text("Почта/ceo@korusell.com")
                }
            })
            Link(destination: URL(string: "sms:+821083872508")!, label: {
                HStack(spacing: 10) {
                    Image("sms")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                    Text("Сообщение")
                }
            })
                Spacer()
            }.padding(.bottom, 30)
        }
}

struct Contacts_Previews: PreviewProvider {
    static var previews: some View {
        Contacts()
    }
}
        
