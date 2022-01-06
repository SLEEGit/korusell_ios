//
//  LoginView.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/12/15.
//

import SwiftUI
import FBSDKLoginKit
import FirebaseAuth
import AuthenticationServices

struct LoginView : View {
    
    @ObservedObject var logging: Logging
    @State var email: String = ""
    @State var password: String = ""
    @State var buttonDisabled: Bool = true
    @State var warningText: String = ""
    @State var showAlert: Bool = false
    @State var isLoading: Bool = false
    @State var isShowInfo: Bool = false
    
    @State var currentNonce: String?
    
    var body: some View {
        ZStack {
            NavigationView {
                Form {
                    
                    Section(header: Text("Введите Ваш e-mail и пароль"), footer: Text(warningText).foregroundColor(Color.red).lineLimit(2).minimumScaleFactor(0.1)) {
                        TextField("Электронная почта", text: $email)
                            .disableAutocorrection(true)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                        SecureField("Пароль", text: $password)
                    }
                    Section {
                        HStack {
                            Spacer()
                            Button(action: {
                                isLoading = true
                                Authentication().signIn(email: email, password: password) {
                                    warningText = Pref.registerCompletion
                                    if warningText == "success" {
                                        logging.isSignedIn = true
                                    }
                                    isLoading = false
                                    print(logging.isSignedIn)
                                }
                            }, label: {
                                Text("Войти")
                            })
                                .disabled(email.isEmpty || password.isEmpty)
                            Spacer()
                        }
                    }
                    Section {
                        HStack {
                            Spacer()
                            Button(action: {
                                fbLogin()
                            }, label: {
                                HStack {
                                    Image("facebook")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 30, height: 30)
                                    Text("Вход через Facebook")
                                        .bold()
                                }
                                
                            })
                            Spacer()
                        }
                    }
                    
                    SignInWithAppleButton(
                        onRequest: { request in
                            let nonce = AppleAuth.randomNonceString()
                            currentNonce = nonce
                            request.requestedScopes = [.fullName, .email]
                            request.nonce = AppleAuth.sha256(nonce)
                        },
                        onCompletion: { result in
                            switch result {
                            case .success(let authResults):
                                switch authResults.credential {
                                case let appleIDCredential as ASAuthorizationAppleIDCredential:
                                    
                                    guard let nonce = currentNonce else {
                                        fatalError("Invalid state: A login callback was received, but no login request was sent.")
                                    }
                                    guard let appleIDToken = appleIDCredential.identityToken else {
                                        fatalError("Invalid state: A login callback was received, but no login request was sent.")
                                    }
                                    guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                                        print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                                        return
                                    }
                                    
                                    let credential = OAuthProvider.credential(withProviderID: "apple.com",idToken: idTokenString,rawNonce: nonce)
                                    Auth.auth().signIn(with: credential) { (authResult, error) in
                                        if (error != nil) {
                                            // Error. If error.code == .MissingOrInvalidNonce, make sure
                                            // you're sending the SHA256-hashed nonce as a hex string with
                                            // your request to Apple.
                                            print(error?.localizedDescription as Any)
                                            return
                                        }
                                        logging.isSignedIn = true
                                        Pref.userDefault.set(true, forKey: "usersignedin")
                                        Pref.userDefault.synchronize()
                                        isLoading = false
                                        print(logging.isSignedIn)
                                        print("signed in")
                                    }
                                    
                                    print("\(String(describing: Auth.auth().currentUser?.uid))")
                                default:
                                    break
                                    
                                }
                            default:
                                break
                            }
                        }
                    ).listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .background(Color.black)
                    
                    Section(header: Text("Создать новый аккаунт")) {
                        NavigationLink(destination: RegistrationView()) {
                            Text("Зарегистрироваться")
                                .foregroundColor(.accentColor)
                        }
                    }
                }.navigationBarTitle("Войти")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button(action: {
                                isShowInfo = true
                            }, label: {
                                Text("ℹ️")
                            }).alert(isPresented: $isShowInfo) {
                                Alert(
                                    title: Text("Чтобы разместить свой бизнес или объявление, создайте аккаунт"),
                                    dismissButton: .default(Text("Ок"))
                                )
                            }
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                Authentication().passwordResetRequest(email: email, onSuccess: {
                                    showAlert = true
                                    print("---> onSuccess")
                                }) { error in
                                    
                                    warningText = error
                                }
                            }, label: {
                                Text("Забыли пароль?")
                            }).alert(isPresented: $showAlert) {
                                Alert(
                                    title: Text("На Вашу почту отправлена ссылка для восстановления пароля"),
                                    dismissButton: .default(Text("Ок"))
                                )
                            }
                        }
                    }
                
            }.disabled(isLoading)
            if isLoading {
                ProgressView().progressViewStyle(CircularProgressViewStyle(tint: Color("textColor")))
                    .background(Color(UIColor.systemGroupedBackground).opacity(0.1))
            }
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
                isLoading = true
            }
        }
        
    }
    
    func getFBUserData(){
        if AccessToken.current != nil{
            GraphRequest(graphPath: "me", parameters: ["fields": "id, name, picture.type(large), email"]).start { (connection, result, err) in
                if(err == nil){
                    self.fbFirebaseAuth()
                    let data:[String:AnyObject] = result as! [String : AnyObject]
                    let data2:[String:AnyObject] = data["picture"]! as! [String : AnyObject]
                    let data3:[String:AnyObject] = data2["data"] as! [String : AnyObject]
                    Pref.userDefault.setValue(data["email"]!, forKey: "email")
                    Pref.userDefault.setValue(data["name"]!, forKey: "name")
                    Pref.userDefault.setValue(data3["url"]!, forKey: "imageURL")
                    print(Pref.userDefault.string(forKey: "imageURL") ?? "")
                } else {
                    print("QWE \(String(describing: err))")
                }
            }
        }
    }
    
    func fbFirebaseAuth(){
        let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
        Auth.auth().signIn(with: credential) { (user, error) in
            if (user != nil){
                isLoading = false
                logging.isSignedIn = true
                Pref.userDefault.set(true, forKey: "usersignedin")
                Pref.userDefault.synchronize()
                Pref.registerCompletion = "success"
                let created_date = Util().dateByTimeZone()
                DB().createUserInDB(user: user!.user, email: Pref.userDefault.string(forKey: "email") ?? "", name: Pref.userDefault.string(forKey: "name") ?? "", created_date: created_date) {}
                DB().getImageByURL(from: URL(string: Pref.userDefault.string(forKey: "imageURL")!)!) { image in
                    DB().postImage(image: image, directory: "avatars", uid: user?.user.uid ?? "", quality: 1.0)
                }
            } else {
                let errorText: String  = error?.localizedDescription ?? "Не удалось авторизоваться!"
                Pref.registerCompletion = errorText
                print(errorText)
                warningText = "e-mail уже используется! Попробуйте зайти через e-mail или используя apple ID"
                isLoading = false
            }
        }
    }
    
}

//struct LoginView_Preview: PreviewProvider {
//    static var previews: some View {
//        LoginView(logging: lo)
//    }
//}
