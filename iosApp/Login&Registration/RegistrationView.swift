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
    
    @State var phonenumber: String = ""
    @State var code: String = ""
    @State var ID: String = ""
    
    @State var showingAlertSuccess: Bool = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var showWarning: Bool = false
    @State var warningText: String = ""
    @State var isEmailValid: Bool = false
    @State var isPassValid: Bool = false
    @State var showingHint: Bool = false
    @ObservedObject var logging = Logging()
    var body: some View {
        Form {
            Section(header: Text("Введите Ваш e-mail и пароль"), footer: Text(warningText).foregroundColor(Color.red).lineLimit(0).minimumScaleFactor(0.1)) {
                HStack {
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
                Image(systemName: "info.circle.fill")
                    .renderingMode(.original)
                    .shadow(radius: 2)
                    .onTapGesture {
                        showingHint = true
                    }.alert(isPresented: $showingHint) {
                        Alert(
                            title: Text("🤔 Используйте существующий e-mail"),
                            dismissButton: .default(Text("Ок"))
                        )
                        
                    }
                }
                SecureField("Пароль", text: $password)
                SecureField("Повторите пароль", text: $rePassword)
                VStack{
                    Text("Введите Ваш номер телефона чтобы проверить ваш Аккаунт")
                    HStack {
                        TextField("+82", text: $code)
                        TextField("Номер телефона", text: $phonenumber)
                    }
                    
                    Button(action: {
                        
                        Authentication().phoneValidation(code: code, number: phonenumber) { ID in
                            self.ID = ID
                        }
                    }, label: {Text("Отправить код")})
                    
                    
                }
            }
            Section {
                
                Button(action: {
                    Authentication().phoneAuth(ID: self.ID, code: "123456") {
                    logging.isSignedIn = true
                    }
                }, label: {Text("Отправить код")})
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
                .alert(isPresented: $showingAlertSuccess) {
                    Alert(
                        title: Text("Регистрация выполнена успешно!"),
                        dismissButton: .default(Text("Ок"))
                    )
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
