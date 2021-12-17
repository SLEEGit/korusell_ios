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
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Введите Ваш e-mail и пароль")) {
                    TextField("Электронная почта", text: $email)
                        .disableAutocorrection(true)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                    SecureField("Пароль", text: $password)
                }
                Section {
                    Button(action: {
                        Authentication().signIn(email: email, password: password) {
                            
                            logging.isSignedIn = true
                            print(logging.isSignedIn)
                        }
                    }, label: {
                        Text("Войти")
                    })
                        .disabled(true)
                }
                Section(header: Text("Создать новый аккаунт")) {
                NavigationLink(destination: RegistrationView()) {
                    Text("Зарегистрироваться")
                        .foregroundColor(.accentColor)
                }
                }
            }.navigationBarTitle("Войти")
        }
    }
}


//struct LoginView_Preview: PreviewProvider {
//    static var previews: some View {
//        LoginView(logging: lo)
//    }
//}
