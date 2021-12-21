//
//  Info.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/12/21.
//

import SwiftUI
import FirebaseAuth

struct Info: View {
    @State var user: FirebaseAuth.User = Auth.auth().currentUser!
    @State private var text = ""
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            Text("Если Вы хотите связаться с рарабочтиками, можете писать на e-mail: ceo@koru.sale или в эту форму: ")
                .padding()
            TextEditor(text: $text)
                .border(.black)
                .padding()
                
            Button("Отправить сообщение") {
                DB().sendMessage(user: user, message: text) {
                    presentationMode.wrappedValue.dismiss()
                }
            }.padding()
        }.padding()
    }
}

//struct Info_Previews: PreviewProvider {
//    static var previews: some View {
//        Info()
//    }
//}
