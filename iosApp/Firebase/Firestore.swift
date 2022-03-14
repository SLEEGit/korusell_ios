//
//  Firestore.swift
//  iosApp
//
//  Created by Sergey Lee on 2022/01/21.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth
import SwiftUI

class FireStore: ObservableObject {
    let db = Firestore.firestore()
    
    func getUser(uid: String, completion: @escaping (User) -> ()) {
        db.collection("users").document(uid).getDocument { (document, error) in
            if let document = document, document.exists {
                let values = document.data()!
                let user = User(dictionary: values)
                completion(user)
            } else {
                print("User does not exist")
            }
        }
    }
    
    func createUserInDB(user: FirebaseAuth.User, email: String = "", name: String = "", created_date: String = "", phone: String = "", image_url: String = "", completion: @escaping () -> Void) {
        db.collection("users").document(user.uid).setData(["uid" : user.uid, "email" : email, "name" : name, "created_date" : created_date, "phone" : phone, "imageUrl" : image_url])
        DispatchQueue.main.async {
            completion()
        }
    }
    
    func updateLastLogin(user: FirebaseAuth.User, last_login: String, completion: @escaping () -> Void) {
        db.collection("users").document(user.uid).updateData(["last_login" : last_login])
        DispatchQueue.main.async {
            completion()
        }
    }
    
    func addNamePhone(user: FirebaseAuth.User, name: String, phone: String, completion: @escaping () -> Void) {
        db.collection("users").document(user.uid).updateData(["name" : name, "phone" : phone])
        DispatchQueue.main.async {
            completion()
        }
    }
    
    func deleteAccount(uid: String, completion: @escaping () -> Void) {
        DB().deleteImage(uid: uid, directory: "avatars")
        db.collection("users").document(uid).delete()
        ServiceManager().deleteService(uid: uid) {}
        AdvManager().deleteAdv(uid: uid) {}
        let user = Auth.auth().currentUser
        
        user?.delete { error in
            if let error = error {
                print("Error on deleting user:: \(error)")
                completion()
            } else {
                print("\(String(describing: user)) successfully deleted")
                completion()
            }
        }
    }
    
}


class MessagesManager: ObservableObject {
    @Published private(set) var messages: [Message] = []
    @Published private(set) var lastMessageId: String = ""
    // Create an instance of our Firestore database
    let db = Firestore.firestore()
    var uid: String = ""
    
    // On initialize of the MessagesManager class, get the messages from Firestore
    init() {
        getMessages(uid: uid)
    }
    
    // Read message from Firestore in real-time with the addSnapShotListener
    func getMessages(uid: String) {
        db.collection("messages").document(uid).collection("test").addSnapshotListener { querySnapshot, error in
            
            // If we don't have documents, exit the function
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \(String(describing: error))")
                return
            }
            
            // Mapping through the documents
            self.messages = documents.compactMap { document -> Message? in
                do {
                    // Converting each document into the Message model
                    // Note that data(as:) is a function available only in FirebaseFirestoreSwift package - remember to import it at the top
                    return try document.data(as: Message.self)
                } catch {
                    // If we run into an error, print the error in the console
                    print("Error decoding document into Message: \(error)")
                    
                    // Return nil if we run into an error - but the compactMap will not include it in the final array
                    return nil
                }
            }
            
            // Sorting the messages by sent date
            self.messages.sort { $0.timestamp < $1.timestamp }
            
            // Getting the ID of the last message so we automatically scroll to it in ContentView
            if let id = self.messages.last?.id {
                self.lastMessageId = id
            }
        }
    }
    
    // Add a message in Firestore
    func sendMessage(text: String) {
        do {
            // Create a new Message instance, with a unique ID, the text we passed, a received value set to false (since the user will always be the sender), and a timestamp
            let newMessage = Message(id: Util().dateForAdv(date: Util().dateByTimeZone()), text: text, received: false, timestamp: Date())
            // Create a new document in Firestore with the newMessage variable above, and use setData(from:) to convert the Message into Firestore data
            // Note that setData(from:) is a function available only in FirebaseFirestoreSwift package - remember to import it at the top
            //            try db.collection("messages").document(Auth.auth().currentUser?.uid ?? "noUser").setData(from: newMessage)
            try db.collection("messages").document(uid ?? "noUser").collection("test").document("user_" + Util().dateForAdv(date: Util().dateByTimeZone())).setData(from: newMessage)
        } catch {
            // If we run into an error, print the error in the console
            print("Error adding message to Firestore: \(error)")
        }
    }
    
    func sendMessageFromAdmin(text: String, userUID: String) {
        do {
            // Create a new Message instance, with a unique ID, the text we passed, a received value set to false (since the user will always be the sender), and a timestamp
            let newMessage = Message(id: Util().dateForAdv(date: Util().dateByTimeZone()), text: text, received: true, timestamp: Date())
            // Create a new document in Firestore with the newMessage variable above, and use setData(from:) to convert the Message into Firestore data
            // Note that setData(from:) is a function available only in FirebaseFirestoreSwift package - remember to import it at the top
            //            try db.collection("messages").document(Auth.auth().currentUser?.uid ?? "noUser").setData(from: newMessage)
            try db.collection("messages").document(userUID).collection("test").document("user_" + Util().dateForAdv(date: Util().dateByTimeZone())).setData(from: newMessage)
        } catch {
            // If we run into an error, print the error in the console
            print("Error adding message to Firestore: \(error)")
        }
    }
}


class ServiceManager: ObservableObject {
    @Published private(set) var services: [Service] = []
    @Published var city: String = "Все города"
    @Published var category: String = "all"
    let db = Firestore.firestore()
    
    init() {
        getServices()
    }
    
    func getServices() {
        db.collection("services").addSnapshotListener { querySnapshot, error in
            
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \(String(describing: error))")
                return
            }
            
            self.services = documents.compactMap { document -> Service? in
                do {
                    return try document.data(as: Service.self)
                } catch {
                    print("Error decoding document into Service: \(error)")
                    return nil
                }
            }
            
            self.services = self.services.shuffled()
            
            switch self.category {
            case "all":
                self.services = self.services.filter { $0.category == "food" || $0.category == "shop" || $0.category == "connect" || $0.category == "study" || $0.category == "party" || $0.category == "docs" || $0.category == "cars" || $0.category == "health" || $0.category == "transport" || $0.category == "travel" || $0.category == "workshop" || $0.category == "other" || $0.category == "products" || $0.category == "admin" || $0.category == "embassy"}
            case "embassy":
                self.services = self.services.filter { $0.category == "embassy" || $0.category == "admin"}
            case "food":
                self.services = self.services.filter { $0.category == "food" || $0.category == "admin"}
            case "shop":
                self.services = self.services.filter { $0.category == "shop" || $0.category == "admin"}
            case "connect":
                self.services = self.services.filter { $0.category == "connect" || $0.category == "admin"}
            case "study":
                self.services = self.services.filter { $0.category == "study" || $0.category == "admin"}
            case "party":
                self.services = self.services.filter { $0.category == "party" || $0.category == "admin"}
            case "docs":
                self.services = self.services.filter { $0.category == "docs" || $0.category == "admin"}
            case "cars":
                self.services = self.services.filter { $0.category == "cars" || $0.category == "admin"}
            case "health":
                self.services = self.services.filter { $0.category == "health" || $0.category == "admin"}
            case "transport":
                self.services = self.services.filter { $0.category == "transport" || $0.category == "admin"}
            case "travel":
                self.services = self.services.filter { $0.category == "travel" || $0.category == "admin"}
            case "workshop":
                self.services = self.services.filter { $0.category == "workshop" || $0.category == "admin"}
            case "other":
                self.services = self.services.filter { $0.category == "other" || $0.category == "admin"}
            case "products":
                self.services = self.services.filter  { $0.category == "products" || $0.category == "admin"}
            default:
                self.services = self.services.filter  { $0.category == "null" }
            }
            
            switch self.city {
            case "Все города":
                self.services = self.services
            case "Ансан":
                self.services = self.services.filter  { $0.city == "Ансан" || $0.city == "admin"}
            case "Хвасонг":
                self.services = self.services.filter  { $0.city == "Хвасонг" || $0.city == "admin"}
            case "Сеул":
                self.services = self.services.filter  { $0.city == "Сеул" || $0.city == "admin"}
            case "Инчхон":
                self.services = self.services.filter  { $0.city == "Инчхон" || $0.city == "admin"}
            case "Асан":
                self.services = self.services.filter  { $0.city == "Асан" || $0.city == "admin"}
            case "Сувон":
                self.services = self.services.filter  { $0.city == "Сувон" || $0.city == "admin"}
            case "Чхонан":
                self.services = self.services.filter  { $0.city == "Чхонан" || $0.city == "admin"}
            case "Чхонджу":
                self.services = self.services.filter  { $0.city == "Чхонджу" || $0.city == "admin"}
            case "Другой город":
                self.services = self.services.filter  { $0.city != "Чхонан" && $0.city != "Хвасонг" && $0.city != "Ансан" && $0.city != "Асан" && $0.city != "Сеул" && $0.city != "Инчхон" && $0.city != "Хвасонг" && $0.city != "Сувон" && $0.city != "Чхонджу" || $0.city == "admin"}
            default:
                self.services = self.services.filter  { $0.city == "nil" || $0.city == "admin"}
            }
        }
    }
    
    
    //    func postService(text: String) {
    //        let uid = Auth.auth().currentUser!.uid
    //        do {
    //            let newService = Service(id: uid, uid: uid, name: "", category: "", city: "", address: "", phone: "", description: "", latitude: "", longitude: "", social: ["","","","",""], images: "")
    //            try db.collection("services").document(uid).setData(from: newService)
    //        } catch {
    //            print("Error adding message to Firestore: \(error)")
    //        }
    //    }
    
    func getMyService(uid: String, completion: @escaping (Service) -> ()) {
        db.collection("services").document(uid).getDocument { (document, error) in
            if let document = document, document.exists {
                let values = document.data()!
                let service = Service(dictionary: values)
                completion(service)
            } else {
                print("Document does not exist")
            }
        }
    }
    
    func postService(service: Service, completion: @escaping () -> Void) {
        do {
            try db.collection("services").document(service.uid).setData(from: service)
            DispatchQueue.main.async {
                completion()
            }
        } catch {
            print("Error adding message to Firestore: \(error)")
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    func deleteService(uid: String, completion: @escaping () -> Void) {
        db.collection("services").document(uid).delete()
        for i in 0...4 {
            DB().deleteImage(uid: uid + String(i), directory: "images")
        }
        DispatchQueue.main.async {
            completion()
        }
    }
    
}


class AdvManager: ObservableObject {
    @Published private(set) var advs: [Adv] = []
    @Published var workAdvs: [Adv] = []
    @Published private(set) var myAdvs: [Adv] = []
    
    @Published var city: String = "Все города"
    @Published var category: String = "all"
    @Published var subcategory: String = "all"
    let db = Firestore.firestore()
    
    init() {
        getAdvs()
    }
    
    func getAdvs() {
        db.collection("adv").addSnapshotListener { querySnapshot, error in
            
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \(String(describing: error))")
                return
            }
            
            self.workAdvs = documents.compactMap { document -> Adv? in
                do {
                    return try document.data(as: Adv.self)
                } catch {
                    print("Error decoding document into Adv: \(error)")
                    return nil
                }
            }
            
            self.workAdvs = self.workAdvs.filter { $0.isActive == "1" &&  $0.category == "work" }.sorted { $0.updatedAt > $1.updatedAt }
            
            self.advs = documents.compactMap { document -> Adv? in
                do {
                    return try document.data(as: Adv.self)
                } catch {
                    print("Error decoding document into Adv: \(error)")
                    return nil
                }
            }
            
            //            self.advs.sort { $0.createdAt < $1.createdAt }
            self.advs = self.advs.filter { $0.isActive == "1" }.sorted { $0.createdAt > $1.createdAt }
            
            switch self.category {
            case "all":
                self.advs = self.advs.filter { $0.category == "transport" || $0.category == "house" || $0.category == "phone" || $0.category == "hobby" || $0.category == "car" || $0.category == "electronic" || $0.category == "children" || $0.category == "clothes" || $0.category == "sport" || $0.category == "pet" || $0.category == "change" || $0.category == "other" || $0.category == "admin"}
            case "transport":
                self.advs = self.advs.filter { $0.category == "transport" || $0.category == "admin"}
            case "house":
                self.advs = self.advs.filter { $0.category == "house" || $0.category == "admin"}
            case "phone":
                self.advs = self.advs.filter { $0.category == "phone" || $0.category == "admin"}
            case "hobby":
                self.advs = self.advs.filter { $0.category == "hobby" || $0.category == "admin"}
            case "car":
                self.advs = self.advs.filter { $0.category == "car" || $0.category == "admin"}
            case "electronic":
                self.advs = self.advs.filter { $0.category == "electronic" || $0.category == "admin"}
            case "children":
                self.advs = self.advs.filter { $0.category == "children" || $0.category == "admin"}
            case "clothes":
                self.advs = self.advs.filter { $0.category == "clothes" || $0.category == "admin"}
            case "sport":
                self.advs = self.advs.filter { $0.category == "sport" || $0.category == "admin"}
            case "pet":
                self.advs = self.advs.filter { $0.category == "pet" || $0.category == "admin"}
            case "change":
                self.advs = self.advs.filter { $0.category == "change" || $0.category == "admin"}
            case "other":
                self.advs = self.advs.filter { $0.category == "other" || $0.category == "admin"}
            default:
                self.advs = self.advs.filter  { $0.category == "zavod" }
            }
            
            switch self.city {
            case "Все города":
                self.advs = self.advs
                self.workAdvs = self.workAdvs
            case "Ансан":
                self.advs = self.advs.filter { $0.city == "Ансан" || $0.city == "admin"}
                self.workAdvs = self.workAdvs.filter { $0.city == "Ансан" || $0.city == "admin"}
            case "Хвасонг":
                self.advs = self.advs.filter { $0.city == "Хвасонг" || $0.city == "admin"}
                self.workAdvs = self.workAdvs.filter { $0.city == "Хвасонг" || $0.city == "admin"}
            case "Сеул":
                self.advs = self.advs.filter { $0.city == "Сеул" || $0.city == "admin"}
                self.workAdvs = self.workAdvs.filter { $0.city == "Сеул" || $0.city == "admin"}
            case "Инчхон":
                self.advs = self.advs.filter { $0.city == "Инчхон" || $0.city == "admin"}
                self.workAdvs = self.workAdvs.filter { $0.city == "Инчхон" || $0.city == "admin"}
            case "Асан":
                self.advs = self.advs.filter { $0.city == "Асан" || $0.city == "admin"}
                self.workAdvs = self.workAdvs.filter { $0.city == "Асан" || $0.city == "admin"}
            case "Сувон":
                self.advs = self.advs.filter { $0.city == "Сувон" || $0.city == "admin"}
                self.workAdvs = self.workAdvs.filter { $0.city == "Сувон" || $0.city == "admin"}
            case "Чхонан":
                self.advs = self.advs.filter { $0.city == "Чхонан" || $0.city == "admin"}
                self.workAdvs = self.workAdvs.filter { $0.city == "Чхонан" || $0.city == "admin"}
            case "Чхонджу":
                self.advs = self.advs.filter { $0.city == "Чхонджу" || $0.city == "admin"}
                self.workAdvs = self.workAdvs.filter { $0.city == "Чхонджу" || $0.city == "admin"}
            case "Другой город":
                self.advs = self.advs.filter { $0.city != "Чхонан" && $0.city != "Хвасонг" && $0.city != "Ансан" && $0.city != "Асан" && $0.city != "Сеул" && $0.city != "Инчхон" && $0.city != "Хвасонг" && $0.city != "Сувон" && $0.city != "Чхонджу" || $0.city == "admin"}
                self.workAdvs = self.workAdvs.filter { $0.city != "Чхонан" && $0.city != "Хвасонг" && $0.city != "Ансан" && $0.city != "Асан" && $0.city != "Сеул" && $0.city != "Инчхон" && $0.city != "Хвасонг" && $0.city != "Сувон" && $0.city != "Чхонджу" || $0.city == "admin"}
            default:
                self.advs = self.advs.filter { $0.city == "nil" || $0.city == "admin"}
                self.workAdvs = self.workAdvs.filter { $0.city == "nil" || $0.city == "admin"}
            }
            
            switch self.subcategory {
            case "all":
                self.workAdvs = self.workAdvs.filter { $0.subcategory == "factory" || $0.subcategory == "construction" || $0.subcategory == "motel" || $0.subcategory == "cafe" || $0.subcategory == "farm" || $0.subcategory == "delivery" || $0.subcategory == "office" || $0.subcategory == "otherwork" }
            case "factory":
                self.workAdvs = self.workAdvs.filter { $0.subcategory == "factory" }
            case "construction":
                self.workAdvs = self.workAdvs.filter { $0.subcategory == "construction" }
            case "motel":
                self.workAdvs = self.workAdvs.filter { $0.subcategory == "motel" }
            case "cafe":
                self.workAdvs = self.workAdvs.filter { $0.subcategory == "cafe" }
            case "farm":
                self.workAdvs = self.workAdvs.filter { $0.subcategory == "farm" }
            case "delivery":
                self.workAdvs = self.workAdvs.filter { $0.subcategory == "delivery" }
            case "office":
                self.workAdvs = self.workAdvs.filter { $0.subcategory == "office" }
            case "otherwork":
                self.workAdvs = self.workAdvs.filter { $0.subcategory == "otherwork" }
            default:
                self.workAdvs = self.workAdvs.filter { $0.subcategory == "nil" }
            }
        }
    }
    
    func getMyAdvs(completion: @escaping () -> Void) {
        db.collection("adv").addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \(String(describing: error))")
                return
            }
            
            self.advs = documents.compactMap { document -> Adv? in
                do {
                    return try document.data(as: Adv.self)
                } catch {
                    print("Error decoding document into Adv: \(error)")
                    return nil
                }
            }
            self.myAdvs = self.advs.filter { $0.uid.contains(Auth.auth().currentUser?.uid ?? "") }.sorted { $0.updatedAt > $1.updatedAt }
            completion()
            
        }
    }
    
    
    func postAdv(adv: Adv, completion: @escaping () -> Void) {
        do {
            try db.collection("adv").document(adv.uid).setData(from: adv)
            DispatchQueue.main.async {
                completion()
            }
        } catch {
            print("Error adding message to Firestore: \(error)")
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    func deleteAdv(uid: String, completion: @escaping () -> Void) {
        db.collection("adv").document(uid).delete()
        for i in 0...4 {
            DB().deleteImage(uid: uid + "ADV" + String(i), directory: "advImages")
        }
        DispatchQueue.main.async {
            completion()
        }
    }
    
    
    func changeAdvStatus(uid: String, isActive: String, completion: @escaping () -> Void) {
        db.collection("adv").document(uid).updateData(["isActive" : isActive])
        DispatchQueue.main.async {
            completion()
        }
    }
    
}
