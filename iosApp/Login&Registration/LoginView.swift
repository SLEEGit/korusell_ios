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
            VStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                
                VStack {
                    TextField("Электронная почта", text: $email)
                        .padding()
                        .background(Color.gray)
                    
                    SecureField("Пароль", text: $password)
                        .padding()
                        .background(Color.gray)
                    
                    Button(action: {
                        
                        Authentication().signIn(email: email, password: password) {
                            logging.isSignedIn = true
                        }
                        
                    }, label: {
                        Text("Войти")
                            .foregroundColor(.white)
                            .frame(width: 200, height: 50)
                            .cornerRadius(8)
                            .background(Color.blue)
                    })
                    NavigationLink(destination: RegistrationView()) {}
                    Text("Зарегистрироваться")
                        .padding()
                        

                    
                }
                .padding()
                
                Spacer()
            }.onAppear {
                if Pref.userDefault.bool(forKey: "usersignedin") {
                    logging.isSignedIn = true
                }
            }
        }
    }
}

//struct LoginView_Preview: PreviewProvider {
//    static var previews: some View {
//        LoginView(isLoggedIn: true)
//    }
//}
