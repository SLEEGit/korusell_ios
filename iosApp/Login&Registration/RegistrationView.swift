//
//  RegistrationView.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/12/15.
//

import SwiftUI

struct RegistrationView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var rePassword: String = ""
    @State var showingAlert: Bool = false
    @State var showingAlertSuccess: Bool = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var showWarning: Bool = false
    @State var warningText: String = ""
    
    var body: some View {
        Form {
            Section(header: Text("Введите Ваш e-mail и пароль"), footer: Text(warningText).foregroundColor(Color.red)) {
//            Section(footer: Text("test text for footer")) {
//            Section(header: Text("Введите Ваш e-mail и пароль")) {
                TextField("Электронная почта", text: $email)
                    .disableAutocorrection(true)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                SecureField("Пароль", text: $password)
                SecureField("Повторите пароль", text: $rePassword)
            }
            Section {
                Button(action: {
                    if password == "" || email == "" {
                        warningText = "Введите e-mail и пароль!"
                    } else if password != rePassword {
                        warningText = "Пароли не совпадают!"
//                        showingAlert = true
                    } else {
                        warningText = ""
                        Authentication().signUp(email: email, password: password) {
                            showingAlertSuccess = true
                        }
                    }
                    
                }, label: {
                    Text("Зарегистрироваться")
                }).alert("Пароли не совпадают!", isPresented: $showingAlert) {
                    Button("Ок", role: .cancel) {}
                }
                .alert("Регистрация выполнена успешно!", isPresented: $showingAlertSuccess) {
                    Button("Ок") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                
            }
        }.navigationBarTitle("Регистрация")
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
