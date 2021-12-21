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

class DB: ObservableObject {
    let ref = Database.database(url: "https://korusale-default-rtdb.asia-southeast1.firebasedatabase.app")
    
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
    
    func getImage(uid: String, directory: String, completion: @escaping (UIImage) -> ()) {

        let storage = Storage.storage().reference().child("\(directory)/\(uid).jpg")
        var image = UIImage()
        storage.getData(maxSize: 1 * 2048 * 2048) { (metadata, error) in
            if let error = error {
                image = UIImage(named: "avatar")!
                print("Error while uploading file: ", error)
            } else {
                let image1 = UIImage(data: metadata!)
                image = image1!
                print("Metadata: ", metadata)
            }
            completion(image)
        }
        
    }
    
    func fetchData(category: String, completion: @escaping ([Service]) -> ()) {
        ref.reference(withPath: "services2").observeSingleEvent(of: .value, with: { snapshot in
            let values = snapshot.value as! [String : [String:Any]]
            var innerServices: [Service] = []
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
        })
    }
    
    func getUser(uid: String, completion: @escaping (User) -> ()) {
        
        
        ref.reference(withPath: "users").child(uid).getData(completion:  { error, snapshot in
            guard error == nil else {
                print(error!.localizedDescription)
                return;
            }
            let values = snapshot.value as! [String:Any]
            let user = User(dictionary: values)
            completion(user)
        });
    }
    
    func fetchData2(category: String, completion: @escaping ([Service]) -> ()) {
        ref.reference(withPath: "services2").observeSingleEvent(of: .value, with: { snapshot in
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
        let defaultService = Service(uid: "", name: "", category: "", city: "", address: "", phone: "", description: "", latitude: "", longitude: "")
        ref.reference(withPath: "services2").child(uid).getData(completion:  { error, snapshot in
            guard error == nil else {
                print(error!.localizedDescription)
                return;
            }
            print(snapshot.value)
            if snapshot.exists() {
                let values = snapshot.value as! [String:Any]
                let service = Service(dictionary: values)
                DispatchQueue.main.async {
                    print(service)
                    print("Step1")
                    completion(service)
                }
            } else {
                completion(defaultService)
                self.updateBusiness(uid: uid, name: "", category: "", city: "", address: "", phone: "", descrition: "", latitude: "", longitude: "") { }
            }
        })
    }
    
    
    
    //    POST
    func createUserInDB(user: FirebaseAuth.User, completion: @escaping () -> Void) {
        ref.reference(withPath: "users").child(user.uid).setValue(["uid" : user.uid, "email" : user.email, "name" : "", "phone" : ""])
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
    
    func updateBusiness(uid: String, name: String, category: String, city: String, address: String, phone: String, descrition: String, latitude: String, longitude: String, completion: @escaping () -> Void) {

        ref.reference(withPath: "services2").child(uid).updateChildValues(["uid" : uid, "name" : name, "city" : city, "category" : category, "address" : address, "phone" : phone, "description" : descrition, "latitude": latitude, "longitude": longitude])
        DispatchQueue.main.async {
            completion()
        }
    }
    
    
    func postImage(image: UIImage, directory: String, uid: String) {
        let storage = Storage.storage().reference().child("\(directory)/\(uid).jpg")
        
        // Resize the image to 200px in height with a custom extension
        let resizedImage = image
        
        // Convert the image into JPEG and compress the quality to reduce its size
        let data = resizedImage.jpegData(compressionQuality: 0.1)
        
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
}
