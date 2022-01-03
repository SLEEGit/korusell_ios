//
//  DataBase.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/12/09.
//

import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage
import Foundation
import UIKit

class DB: ObservableObject {
    
    let ref = Database.database(url: "https://korusell-default-rtdb.asia-southeast1.firebasedatabase.app/")
    
    //    GET
    
//    func getImage(uid: String, completion: @escaping (URL) -> ()) {
//        let storage = Storage.storage().reference().child("images/\(uid).jpg")
//        storage.downloadURL() { url, error in
//            if let url = url {
//                print(url)
//                completion(url)
//            } else {
//                return
//            }
//
//        }
//    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func getImageByURL(from url: URL, completion: @escaping (UIImage) -> ()) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            // always update the UI from the main thread
            DispatchQueue.main.async() {
                completion(UIImage(data: data)!)
            }
        }
    }
    
    func getImage(uid: String, directory: String, completion: @escaping (UIImage) -> ()) {

        let storage = Storage.storage().reference().child("\(directory)/\(uid).jpg")
        var image = UIImage()
        storage.getData(maxSize: 1 * 1024 * 1024) { (metadata, error) in
            if let error = error {
//                image = UIImage(systemName: "photo")!
                print("Error while uploading file: ", error)
                return
            } else {
                let image1 = UIImage(data: metadata!)
                image = image1!
                print("Metadata: ", metadata!)
            }
            completion(image)
        }
    }
    
    func getServices(category: String, completion: @escaping ([Service]) -> ()) {
        ref.reference(withPath: "services").observeSingleEvent(of: .value, with: { snapshot in
            var innerServices: [Service] = []
            if let values = snapshot.value as? [String : [String:Any]] {
                
                for i in values {
                    let service = Service(dictionary: i.value)
                    innerServices.append(service)
                }
                DispatchQueue.main.async {
                    if category != "all" {
                        innerServices = innerServices.filter { $0.category == category }
                    }
                    completion(innerServices)
                }
            } else {
//                тут надо добавить ошибку для юзера!
                print("FETCHING ERROR!")
                completion(innerServices)
            }
        })
    }
    
    func getAdvs(category: String, completion: @escaping ([Adv]) -> ()) {
        ref.reference(withPath: "adv").observeSingleEvent(of: .value, with: { snapshot in
            var innerServices: [Adv] = []
            if let values = snapshot.value as? [String : [String:Any]] {
                
                for i in values {
                    let adv = Adv(dictionary: i.value)
                    innerServices.append(adv)
                }
                DispatchQueue.main.async {
                    if category != "all" {
                        innerServices = innerServices.filter { $0.category == category }
                    }
                    completion(innerServices)
                }
            } else {
//                тут надо добавить ошибку для юзера!
                print("FETCHING ERROR!")
                completion(innerServices)
            }
        })
    }
    
    func getUser(uid: String, completion: @escaping (User) -> ()) {
        ref.reference(withPath: "users").child(uid).getData(completion:  { error, snapshot in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            if let values = snapshot.value as? [String:Any] {
                let user = User(dictionary: values)
                completion(user)
            } else {
                return
            }

        });
    }
    
    func fetchData2(category: String, completion: @escaping ([Service]) -> ()) {
        ref.reference(withPath: "services").observeSingleEvent(of: .value, with: { snapshot in
            let values = snapshot.value as! [[String:Any]]
            var innerServices: [Service] = []
            for i in values {
                let service = Service(dictionary: i)
                innerServices.append(service)
            }
            DispatchQueue.main.async {
                if category != "all" {
                    innerServices = innerServices.filter { $0.category == category }
                }
                completion(innerServices)
            }
        })
    }
    
    func getMyBusiness(uid: String, completion: @escaping (Service) -> ()) {
        let defaultService = Service(uid: "", name: "", category: "", city: "", address: "", phone: "", description: "", latitude: "", longitude: "", social: ["", "", "", "", ""])
        ref.reference(withPath: "services").child(uid).getData(completion:  { error, snapshot in
            guard error == nil else {
                print(error!.localizedDescription)
                return;
            }
            if snapshot.exists() {
                let values = snapshot.value as! [String:Any]
                let service = Service(dictionary: values)
                DispatchQueue.main.async {
                    completion(service)
                }
            } else {
                completion(defaultService)
                self.updateBusiness(uid: uid, name: "", category: "", city: "", address: "", phone: "", descrition: "", latitude: "", longitude: "", social: ["", "", "", "", ""]) { }
            }
        })
    }
    
    
    
    //    POST
    func createUserInDB(user: FirebaseAuth.User, email: String = "", name: String = "", created_date: String = "", phone: String = "", completion: @escaping () -> Void) {
        ref.reference(withPath: "users").child(user.uid).updateChildValues(["uid" : user.uid, "email" : email, "name" : name, "created_date" : created_date, "phone" : phone])
        DispatchQueue.main.async {
            completion()
        }
    }
    
    func updateLastLogin(user: FirebaseAuth.User, last_login: String, completion: @escaping () -> Void) {
        ref.reference(withPath: "users").child(user.uid).updateChildValues(["last_login" : last_login])
        DispatchQueue.main.async {
            completion()
        }
    }
    
    func addNamePhone(user: FirebaseAuth.User, name: String, phone: String, completion: @escaping () -> Void) {
        ref.reference(withPath: "users").child(user.uid).updateChildValues(["name" : name, "phone" : phone])
        DispatchQueue.main.async {
            completion()
        }
    }
    
    
    
    func sendMessage(user: FirebaseAuth.User, message: String, completion: @escaping () -> Void) {
        ref.reference(withPath: "messages").child(user.uid).updateChildValues([Date().description : message, "user" : user.email!])
        DispatchQueue.main.async {
            completion()
        }
    }
    
    func updateBusiness(uid: String, name: String, category: String, city: String, address: String, phone: String, descrition: String, latitude: String, longitude: String, social: [String], completion: @escaping () -> Void) {

        ref.reference(withPath: "services").child(uid).updateChildValues(["uid" : uid, "name" : name, "city" : city, "category" : category, "address" : address, "phone" : phone, "description" : descrition, "latitude": latitude, "longitude": longitude, "social": social])
        DispatchQueue.main.async {
            completion()
        }
    }
    
    
    func postImage(image: UIImage, directory: String, uid: String, quality: Double) {
        let storage = Storage.storage().reference().child("\(directory)/\(uid).jpg")
        
        // Resize the image to 200px in height with a custom extension
        let resizedImage = image
        
        // Convert the image into JPEG and compress the quality to reduce its size
        let data = resizedImage.jpegData(compressionQuality: quality)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        if let data = data {
            storage.putData(data, metadata: metadata) { (metadata, error) in
                if let error = error {
                    print("Error while uploading file: ", error)
                }
                if let metadata = metadata {
                    print("Metadata: ", metadata)
                }
            }
        }
    }
    
    // DELETE
    func deleteImage(uid: String, directory: String) {
        let storage = Storage.storage().reference().child("\(directory)/\(uid).jpg")
        storage.delete { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Image deleted!")
            }
        }
    }
    
    func deleteAccount(uid: String) {
        deleteImage(uid: uid, directory: "avatars")
        ref.reference(withPath: "users").child(uid).removeValue()
        deleteBusiness(uid: uid)
    }
    
    func deleteBusiness(uid: String) {
        deleteImage(uid: uid, directory: "images")
        ref.reference(withPath: "services").child(uid).removeValue()
        
    }
    

    
}
