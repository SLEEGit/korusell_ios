//
//  Profile.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/12/05.
//

import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    
    @ObservedObject var logging: Logging
    @State var user: FirebaseAuth.User = Auth.auth().currentUser!
    @State private var showingAlert = false
    @State var name: String = ""
    @State var phone: String = ""
    @State var avatar: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Image("avatar")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .cornerRadius(75)
                        .listRowSeparator(.hidden)
                    Text(user.email ?? "")
                        .font(.title3)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .listRowInsets(EdgeInsets())
                .background(Color(UIColor.systemGroupedBackground))
                NavigationLink(destination: Text("Редактировать имя")) {
                    HStack {
                        Text("Имя")
                        Spacer()
                        Text(name)
                    }
                }
                NavigationLink(destination: Text("Редактировать имя")) {
                    HStack {
                        Text("Номер телефона")
                        Spacer()
                        Text(phone)
                    }
                }
                Section {
                    NavigationLink(destination: Text("Мой Бизнес")) {
                        Text("Мой Бизнес")
                    }
                    NavigationLink(destination: Text("Скоро мы добавим сюда объявления! 😇")) {
                        Text("Мои Объявления")
                    }
                }
                Section {
                    Button(action: {
                        showingAlert = true
                    })
                    {
                        HStack {
                            Spacer()
                            Text("Выйти")
                                .foregroundColor(Color.red)
                            Spacer()
                        }
                    }
                    .alert("Вы действительно хотите выйти?", isPresented: $showingAlert) {
                        Button("Отмена", role: .cancel) {}
                        Button("Выйти") {
                            Authentication().signOut() {
                                logging.isSignedIn = false
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Моя страница")
        }.onAppear {
            DB().getUser(uid: user.uid) { user in
                name = user.name ?? ""
                phone = user.phone ?? ""
            }

        }
    }
}
    //struct Profile_Previews: PreviewProvider {
    //    static var previews: some View {
    //        Profile(person: example3, viewModel: viewModel)
    //    }
    //}
    
    //#if DEBUG
    ////let example3 = Person(_id: "HNyHZZjtq298izgub", avatar: "", name: "sd", username: "username", email:"asdasda", phone: "010 1233 1111")
    //let example3 = User(uid: "123", displayName: "dis name", email: "test@test.thisistest", avatar: "avatar", phone: "010-0000-0000")
    //#endif
    
    
    //struct ExtractedView: View {
    //    var body: some View {
    //        Form {
    //            Section {
    //                HStack {
    //                    Text("Имя")
    //                        .font(.caption)
    //                    Spacer()
    //                    TextField(namePlaceholder, text: $name)
    //                        .font(.caption)
    //                }
    //                HStack {
    //                    Text("Номер телефона")
    //                        .font(.caption)
    //                    Spacer()
    //                    TextField(phonePlaceholder, text: $phone)
    //                        .font(.caption)
    //                }
    //            }
    //            Section {
    //                Button(action: {
    //                    showingAlert = true
    //                })
    //                {
    //                    HStack {
    //                        Spacer()
    //                        Text("Выйти")
    //                            .foregroundColor(Color.red)
    //                        Spacer()
    //                    }
    //                }
    //                .alert("Вы действительно хотите выйти?", isPresented: $showingAlert) {
    //                    Button("Отмена", role: .cancel) {}
    //                    Button("Выйти") {
    //                        Authentication().signOut() {
    //                            logging.isSignedIn = false
    //                        }
    //                    }
    //                }
    //            }
    //        }
    //    }
    //}
    //        .toolbar {
    //            Button("Обновить данные") {
    //                DB().addNamePhone(user: user, name: name, phone: phone) {
    //                    showingAlert2 = true
    //                }
    //            }.alert("Данные успешно обновлены", isPresented: $showingAlert2) {
    //                Button("Ок", role: .cancel) {}
    //            }
    //        }
    //}.onAppear {
    //    DB().getUser(uid: user.uid) { user in
    //        name = user.name ?? ""
    //        phone = user.phone ?? ""
    //    }
    //}
