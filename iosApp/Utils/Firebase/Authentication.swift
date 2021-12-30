//
//  Authentication.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/12/15.
//

import Foundation
import FirebaseAuth
import FBSDKLoginKit

class Authentication {

    
    func signInFacebook(completion: @escaping () -> Void) {
        Auth.auth().languageCode = "ru";
        let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
        Auth.auth().signIn(with: credential) { (result, error) in
            guard result != nil, error == nil else {
                let errorText: String  = error?.localizedDescription ?? "Не удалось авторизоваться!"
                Pref.registerCompletion = errorText

                print(errorText)
                completion()
                return
            }
            DispatchQueue.main.async {
                Pref.userDefault.set(true, forKey: "usersignedin")
                Pref.userDefault.synchronize()
                Pref.registerCompletion = "success"
                completion()
                print("SIGNED IN   \(String(describing: Auth.auth().currentUser?.email))")
            }
        }
    }

    
    func signIn(email: String, password: String, completion: @escaping () -> Void) {
        Auth.auth().languageCode = "ru";
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else {
                let errorText: String  = error?.localizedDescription ?? "Не удалось авторизоваться!"
                Pref.registerCompletion = errorText

                print(errorText)
                completion()
                return
            }
//            DispatchQueue.main.async {
//                if let user = result?.user {
//                    DB().getUser(uid: user.uid) { gotUser in
//                        if user.uid != gotUser.uid {
//                            DB().createUserInDB(user: user) {
//                            }
//                        }
//                    }
//
//                }
                Pref.userDefault.set(true, forKey: "usersignedin")
                Pref.userDefault.synchronize()
                Pref.registerCompletion = "success"
                completion()
                print("SIGNED IN   \(String(describing: Auth.auth().currentUser?.email))")
//            }
        }
    }
    
    func phoneValidation(code: String, number: String, completion: @escaping (String) -> ()) {
        PhoneAuthProvider.provider().verifyPhoneNumber("+"+code+number, uiDelegate: nil) { (ID, err) in
            if err != nil {
                print("FAIL")
                print(err?.localizedDescription as Any)
                return
            } else {
                print("SUCCESS")
                print(ID as Any)
                completion(ID!)
            }
        }
    }
    
    func phoneAuth(ID: String, code: String, completion: @escaping () -> Void) {
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: ID, verificationCode: code)
        
        Auth.auth().signIn(with: credential) { (res, err) in
            if err != nil {
                print("FAIL")
                print(err?.localizedDescription as Any)
            } else {
                completion()
                print("SUCCESS")
            }
        }
        
    }
    
    func signOut(completion: @escaping () -> Void) {
        Auth.auth().languageCode = "ru";
        do {
            try Auth.auth().signOut()
            Pref.userDefault.set(false, forKey: "usersignedin")
            Pref.userDefault.synchronize()
            print("SIGNED OUT   \(String(describing: Auth.auth().currentUser?.email))")
            completion()
        } catch {
                print("ERROR SIGN OUT")
        }
    }
    

    func signUp(email: String, password: String, phone: String, completion: @escaping () -> Void) {
        Auth.auth().languageCode = "ru";
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else {
                let errorText: String  = error?.localizedDescription ?? "Не удалось зарегистрироваться!"
                Pref.registerCompletion = errorText

                print(errorText)
                completion()
                return
            }
            if let user = result?.user {
                DB().createUserInDB(user: user, phone: phone) {
                    Pref.registerCompletion = "success"
                    completion()
                }
            }
        }
    }
    
    func passwordResetRequest(email: String,
                              onSuccess: @escaping() -> Void,
                              onError: @escaping(_ errorMessage: String) -> Void) {
        
        Auth.auth().languageCode = "ru";
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if error != nil {
                onError(error!.localizedDescription)
            } else {
                onSuccess()
            }
        }
    }
    
}
        
extension AuthErrorCode {
    var description: String? {
        switch self {
        case .emailAlreadyInUse:
            return "Этот e-mail уже используется"
        case .userDisabled:
            return "Пользователь отключен"
        case .operationNotAllowed:
            return "Недопустимая операция"
        case .invalidEmail:
            return "Неверный e-mail"
        case .wrongPassword:
            return "Неверный пароль"
        case .userNotFound:
            return "Пользователь с таким e-mail не найден"
        case .networkError:
            return "Проблемы с интернетом"
        case .weakPassword:
            return "Пароль слижком слабый"
        case .missingEmail:
            return "Введите существующий e-mail"
        case .internalError:
            return "Внутренняя ошибка"
        case .invalidCustomToken:
            return "Ошибка токена"
        case .tooManyRequests:
            return "Было сделано слижком много запросов!"
        default:
            return nil
        }
    }
}

public extension Error {
    var localizedDescription: String {
        let error = self as NSError
        if error.domain == AuthErrorDomain {
            if let code = AuthErrorCode(rawValue: error.code) {
                if let errorString = code.description {
                    return errorString
                }
            }
        }
//        else if error.domain == FirestoreErrorDomain {
//            if let code = FirestoreErrorCode(rawValue: error.code) {
//                if let errorString = code.description {
//                   return errorString
//                }
//            }
//        } else if error.domain == StorageErrorDomain {
//            if let code = StorageErrorCode(rawValue: error.code) {
//                if let errorString = code.description {
//                    return errorString
//                }
//            }
//        }
        return error.localizedDescription
    }
}
