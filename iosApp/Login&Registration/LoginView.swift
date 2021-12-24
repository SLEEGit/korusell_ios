//
//  LoginView.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/12/15.
//

import SwiftUI

struct LoginView : View {
    
    @ObservedObject var logging: Logging
    @State var email: String = ""
    @State var password: String = ""
    @State var buttonDisabled: Bool = true
    @State var warningText: String = ""
    @State var showAlert: Bool = false
    var body: some View {
        NavigationView {
            Form {
                Section {
                    FaceBookLoginView().onDisappear {
                        logging.isSignedIn = Pref.isLoggedIn
                    }
                        .frame(width: 180, height: 50, alignment: .center).padding(10)
                }
                Section(header: Text("Введите Ваш e-mail и пароль"), footer: Text(warningText).foregroundColor(Color.red).lineLimit(0).minimumScaleFactor(0.1)) {
                    TextField("Электронная почта", text: $email)
                        .disableAutocorrection(true)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                    SecureField("Пароль", text: $password)
                }
                Section {
                    Button(action: {
                        
                        Authentication().signIn(email: email, password: password) {
                            warningText = Pref.registerCompletion
                            if warningText == "success" {
                                logging.isSignedIn = true
                            }
                            print(logging.isSignedIn)
                        }
                    }, label: {
                        Text("Войти")
                    })
                        .disabled(email.isEmpty || password.isEmpty)
                }
                Section(header: Text("Создать новый аккаунт")) {
                NavigationLink(destination: RegistrationView()) {
                    Text("Зарегистрироваться")
                        .foregroundColor(.accentColor)
                }
                }
            }.toolbar {
                Button(action: {
                    Authentication().passwordResetRequest(email: email, onSuccess: {
                        showAlert = true
                        print("---> onSuccess")
                    }) { error in
                        
                        warningText = error
                    }
                }, label: {
                    Text("Забыли пароль?")
                }).alert("На Вашу почту отправлена ссылка для восстановления пароля", isPresented: $showAlert) {
                    Button("Ок", role: .cancel) {}
                }
            }
            .navigationBarTitle("Войти")
        }
    }
}


//struct LoginView_Preview: PreviewProvider {
//    static var previews: some View {
//        LoginView(logging: lo)
//    }
//}
