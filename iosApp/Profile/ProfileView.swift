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
    @State private var showingAlert2 = false
    @State var name: String = ""
    @State var phone: String = ""
    @State var namePlaceholder: String = "Введите Ваше имя"
    @State var phonePlaceholder: String = "Введите Ваш номер телефона"
    @State var avatar: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Image("avatar")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 150)
                        .cornerRadius(75)
                    Text(user.email ?? "")
                        .font(.title3)
                }
                Form {
                    Section {
                        HStack {
                            Text("Имя")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Spacer()
                            TextField(namePlaceholder, text: $name)
                                .font(.caption)
                        }
                        HStack {
                            Text("Номер телефона")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Spacer()
                            TextField(phonePlaceholder, text: $phone)
                                .font(.caption)
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
            }.navigationBarTitle("Моя страница")
            .toolbar {
                Button("Обновить данные") {
                    DB().addNamePhone(user: user, name: name, phone: phone) {
                        showingAlert2 = true
                    }
                }.alert("Данные успешно обновлены", isPresented: $showingAlert2) {
                    Button("Ок", role: .cancel) {}
                }
            }
        }.onAppear {
            print("IN PROFILE CURRENT USER    \(Auth.auth().currentUser?.email)")
            print("IN PROFILE USER    \(user.email)")
            DB().getUser(uid: user.uid) { user in
                namePlaceholder = user.name ?? ""
                phonePlaceholder = user.phone ?? ""
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

