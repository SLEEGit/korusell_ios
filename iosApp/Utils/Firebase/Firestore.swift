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

class MessagesManager: ObservableObject {
    @Published private(set) var messages: [Message] = []
    @Published private(set) var lastMessageId: String = ""
    
    // Create an instance of our Firestore database
    let db = Firestore.firestore()
    
    // On initialize of the MessagesManager class, get the messages from Firestore
    init() {
        getMessages()
    }

    // Read message from Firestore in real-time with the addSnapShotListener
    func getMessages() {
        db.collection("messages").document(Auth.auth().currentUser?.uid ?? "noUser").collection("test").addSnapshotListener { querySnapshot, error in
            
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
            try db.collection("messages").document(Auth.auth().currentUser?.uid ?? "noUser").collection("test").document("user_" + Util().dateForAdv(date: Util().dateByTimeZone())).setData(from: newMessage)
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
    @Published var openServices: [Service] = []
    
    @Published var city: String = ""
    @Published var category: String = "" 
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
            
            self.openServices = self.services.filter { $0.city == self.city && $0.category == self.category }
            
//            self.services.sort { $0.timestamp < $1.timestamp }
            
//            if let id = self.messages.last?.id {
//                self.lastMessageId = id
//            }
        }
    }
    
    
    func postService(text: String) {
        let uid = Auth.auth().currentUser!.uid
        do {
            let newService = Service(id: uid, uid: uid, name: "", category: "", city: "", address: "", phone: "", description: "", latitude: "", longitude: "", social: ["","","","",""], images: "")
            try db.collection("services").document(uid).setData(from: newService)
        } catch {
            print("Error adding message to Firestore: \(error)")
        }
    }
    
}


class AdvManager: ObservableObject {
    @Published private(set) var advs: [Adv] = []
    @Published var openAdv: [Adv] = []
    
    @Published var city: String = "Все города"
    @Published var category: String = "all"
    let db = Firestore.firestore()

    init() {
        getAdvs()
    }

    func getAdvs() {
        print("coming to getadvs")
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
            case "Ансан":
                self.advs = self.advs.filter { $0.city == "Ансан" || $0.city == "admin"}
            case "Хвасонг":
                self.advs = self.advs.filter { $0.city == "Хвасонг" || $0.city == "admin"}
            case "Сеул":
                self.advs = self.advs.filter { $0.city == "Сеул" || $0.city == "admin"}
            case "Инчхон":
                self.advs = self.advs.filter { $0.city == "Инчхон" || $0.city == "admin"}
            case "Асан":
                self.advs = self.advs.filter { $0.city == "Асан" || $0.city == "admin"}
            case "Сувон":
                self.advs = self.advs.filter { $0.city == "Сувон" || $0.city == "admin"}
            case "Чхонан":
                self.advs = self.advs.filter { $0.city == "Чхонан" || $0.city == "admin"}
            case "Чхонджу":
                self.advs = self.advs.filter { $0.city == "Чхонджу" || $0.city == "admin"}
            case "Другой город":
                self.advs = self.advs.filter { $0.city != "Чхонан" && $0.city != "Хвасонг" && $0.city != "Ансан" && $0.city != "Асан" && $0.city != "Сеул" && $0.city != "Инчхон" && $0.city != "Хвасонг" && $0.city != "Сувон" && $0.city != "Чхонджу" || $0.city == "admin"}
            default:
                self.advs = self.advs.filter { $0.city == "nil" || $0.city == "admin"}
            }
            
        }
    }
    
    

    
    
    func postAdv(adv: Adv) {
        let uid = Auth.auth().currentUser!.uid
        do {
            try db.collection("adv").document(uid).setData(from: adv)
        } catch {
            print("Error adding message to Firestore: \(error)")
        }
    }
    
}
