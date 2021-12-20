//
//  DataBase.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/12/09.
//

import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage

class DB: ObservableObject {
    let ref = Database.database(url: "https://korusale-default-rtdb.asia-southeast1.firebasedatabase.app")
    
    //    GET
    
    func getImage(uid: String, completion: @escaping (UIImage) -> ()) {

        let storage = Storage.storage().reference().child("images/\(uid).jpeg")
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
    
    func getAvatar(uid: String, completion: @escaping (UIImage) -> ()) {

        let storage = Storage.storage().reference().child("avatars/\(uid).jpg")
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
        let defaultService = Service(_id: "", owner: uid, name: "avatar", category: "", city: "", address: "", phone: "", image: [""], description: "", latitude: "", longitude: "")
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
                self.updateBusiness(uid: uid, _id: "", name: "", city: "", address: "", phone: "", descrition: "", owner: uid, image: ["avatar"], latitude: "", longitude: "") { }
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
    
    func updateBusiness(uid: String, _id: String, name: String, city: String, address: String, phone: String, descrition: String, owner: String, image: [String], latitude: String, longitude: String, completion: @escaping () -> Void) {

        ref.reference(withPath: "services2").child(uid).updateChildValues(["_id:" : _id, "name" : name, "city" : city, "address" : address, "phone" : phone, "description" : descrition, "owner" : owner, "image" : image, "latitude": latitude, "longitude": longitude])
        DispatchQueue.main.async {
            completion()
        }
    }
    
    
    func postAvatar(image: UIImage, uid: String) {
        let storage = Storage.storage().reference().child("avatars/\(uid).jpg")
        
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
