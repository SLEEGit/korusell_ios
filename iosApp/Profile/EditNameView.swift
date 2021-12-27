//
//  EditNameView.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/12/18.
//

import SwiftUI
import FirebaseAuth

struct EditNameView: View {
    @Binding var name: String
    @Binding var phone: String
    @State var user: FirebaseAuth.User = Auth.auth().currentUser!
    @State private var showingAlert = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        Form {
            Section(header: Text("Укажите Ваше имя и фамилию")) {
                TextField("Пример Примеров", text: $name)
            }
            Section(header: Text("Укажите Ваш номер телефона")) {
                TextField("010-0000-0000", text: $phone)
                    
            }
            Section {
                HStack {
                    Spacer()
                    Button("Обновить данные") {
                        DB().addNamePhone(user: user, name: name, phone: phone) {
                            showingAlert = true
                        }
                    }.alert("Данные успешно обновлены", isPresented: $showingAlert) {
                        Button("Ок") {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                    Spacer()
                }
            }
        }.onAppear {
            DB().getUser(uid: user.uid) { user in
                self.name = user.name ?? ""
                self.phone = user.phone ?? ""
            }
        }
    }

}

//struct EditNameView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditNameView()
//    }
//}
