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
    @State var showingAlertSuccess: Bool = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var showWarning: Bool = false
    @State var warningText: String = ""
    @State var isEmailValid: Bool = false
    @State var isPassValid: Bool = false
    
    var body: some View {
        Form {
            Section(header: Text("Введите Ваш e-mail и пароль"), footer: Text(warningText).foregroundColor(Color.red).lineLimit(0).minimumScaleFactor(0.1)) {
//            Section(footer: Text("test text for footer")) {
//            Section(header: Text("Введите Ваш e-mail и пароль")) {
                
                TextField("Электронная почта", text: $email, onEditingChanged: { (isChanged) in
                    if !isChanged {
                        if Util().textFieldValidatorEmail(self.email) {
                            self.isEmailValid = true
                        } else {
                            warningText = "Неверный формат эл. почты!"
                            self.isEmailValid = false
                            self.email = ""
                        }
                    }
                })
                    .disableAutocorrection(true)
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                    .autocapitalization(.none)
                SecureField("Пароль", text: $password)
                SecureField("Повторите пароль", text: $rePassword)
            }
            Section {
                Button(action: {
                    if password != rePassword {
                        warningText = "Пароли не совпадают!"
                    } else if password.count < 8 {
                        warningText = "Пароль должен содержать минимум 8 символов!"
                    } else {
                        warningText = ""
                        Authentication().signUp(email: email, password: password) {
                            warningText = Pref.registerCompletion
                            if warningText == "success" {
                                showingAlertSuccess = true
                            }
                            
                        }
                    }
                    
                }, label: {
                    Text("Зарегистрироваться")
                })
                .alert("Регистрация выполнена успешно!", isPresented: $showingAlertSuccess) {
                    Button("Ок") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                .disabled(email.isEmpty || password.isEmpty || rePassword.isEmpty)
                
            }
        }.navigationBarTitle("Регистрация")
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
