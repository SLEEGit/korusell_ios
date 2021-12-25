//
//  LoginView.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/12/15.
//

import SwiftUI
import FBSDKLoginKit
import FirebaseAuth

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
                    Button(action: {
                        fbLogin()
                    }, label: {
                        HStack {
                            Image("facebook")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 30, height: 30)
                            Text("Войти через Фейсбук")
                        }
                        
                    })
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
    
    func fbLogin(){
        let cont = UIHostingController(rootView: self) // convert to UIController from SwiftUI
        // 'FBSDKLoginManager' has been renamed to 'LoginManager'
        let fbLoginManager: LoginManager = LoginManager()
        fbLoginManager.logIn(permissions: ["email"], from: cont) { (result, err) in
            if err != nil{
                print("Process error")
            }else if result?.isCancelled == true{
                print("Cancelled")
            }else{
                print("Logged in")
                self.getFBUserData()
            }
        }
        
    }
    
    func getFBUserData(){
        if AccessToken.current != nil{
            GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start { (connection, result, err) in
                if(err == nil){
                    self.fbFirebaseAuth()
                    let data:[String:AnyObject] = result as! [String : AnyObject]
                    let data2:[String:AnyObject] = data["picture"]! as! [String : AnyObject]
                    let data3:[String:AnyObject] = data2["data"] as! [String : AnyObject]
                    Pref.userDefault.setValue(data["first_name"]!, forKey: "first_name")
                    Pref.userDefault.setValue(data["name"]!, forKey: "name")
                    Pref.userDefault.setValue(data3["url"]!, forKey: "imageURL")
                    print(Pref.userDefault.string(forKey: "imageURL"))
                } else {
                    print("QWE \(err)")
                }
            }
        }
    }
    
    func fbFirebaseAuth(){
        let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
        Auth.auth().signIn(with: credential) { (user, error) in
            if (user != nil){
                let created_date = Date.now.description
                DB().createUserInDB(user: user!.user, name: Pref.userDefault.string(forKey: "name") ?? "", created_date: created_date) {   
                }
                logging.isSignedIn = true
                Pref.userDefault.set(true, forKey: "usersignedin")
                Pref.userDefault.synchronize()
                Pref.registerCompletion = "success"
                DB().getImageByURL(from: URL(string: Pref.userDefault.string(forKey: "imageURL")!)!) { image in
                    DB().postImage(image: image, directory: "avatars", uid: user?.user.uid ?? "", quality: 1.0)
                }
            } else {
                let errorText: String  = error?.localizedDescription ?? "Не удалось авторизоваться!"
                Pref.registerCompletion = errorText
                print(errorText)
                warningText = "Войтите используя e-mail"
            }
        }
    }
}

//struct LoginView_Preview: PreviewProvider {
//    static var previews: some View {
//        LoginView(logging: lo)
//    }
//}