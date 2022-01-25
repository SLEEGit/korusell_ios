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
    @ObservedObject var logging: Logging
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var firestore = FireStore()
    
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
                    Button(action: {
                        firestore.addNamePhone(user: user, name: name, phone: phone) {
                            showingAlert = true
                        }
                    }, label: {
                        Text("Обновить данные")
                    }).alert(isPresented: $showingAlert) {
                            Alert(
                                title: Text("Данные успешно обновлены"),
                                dismissButton: .destructive(Text("Ок"), action: {
                                    presentationMode.wrappedValue.dismiss()
                                })
                            )
                    }
                    Spacer()
                }
            }
            Section {
                HStack {
                    Spacer()
                    Button(action: {
                            showingAlert = true
                    }, label: {
                        Text("Удалить аккаунт")
                            .foregroundColor(Color.red)
                    }).alert(isPresented: $showingAlert) {
                            Alert(
                                title: Text("Ваш аккаунт будет удален! Вся информация будет утеряна!"),
                                primaryButton: .destructive(Text("Удалить аккаунт"), action: {
                                    firestore.deleteAccount(uid: user.uid) {
//                                    DB().deleteAccount(uid: user.uid) {
                                        Authentication().signOut() {
                                            logging.isSignedIn = false
                                        }
                                    }
//                                    presentationMode.wrappedValue.dismiss()
                                }),
                                secondaryButton: .cancel(Text("Отмена"))
                            )
                    }
                    Spacer()
                }
            }
            
        }
        .onAppear {
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
