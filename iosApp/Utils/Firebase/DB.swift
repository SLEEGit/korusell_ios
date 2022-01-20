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

var globalImages: [UIImage] = []

class DB: ObservableObject {
    
    let ref = Database.database(url: "https://korusell-default-rtdb.asia-southeast1.firebasedatabase.app/")
    
    //    GET
    
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
    
//    func getMultipleImage(completion: @escaping ([UIImage]) -> ()) {
//        var images: [UIImage] = []
//        for i in globalServices {
//            for j in 0...3 {
//                let storage = Storage.storage().reference().child("images/\(i.uid)\(j)")
//                storage.getData(maxSize: 1 * 1024 * 1024) { (metadata, error) in
//                    if let error = error {
//                        print("Error while uploading file: ", error)
//                        return
//                    } else {
//                        let image = UIImage(data: metadata!)
//                        globalImages.append(image!)
//                        //                        print("Metadata: ", metadata!)
//                    }
//                }
//            }
//        }
//        completion(images)
//    }
    
    func getMultiImages(uid: String, directory: String, completion: @escaping ([UIImage]) -> ()) {
        var images: [UIImage] = []
        let storage = Storage.storage().reference().child("\(directory)/\(uid)0.jpg")
        storage.getData(maxSize: 1 * 1024 * 1024) { (metadata, error) in
            if error != nil {
                completion(images)
                return
            } else {
                let image1 = UIImage(data: metadata!)
                images.append(image1!)
                let storage1 = Storage.storage().reference().child("\(directory)/\(uid)1.jpg")
                storage1.getData(maxSize: 1 * 1024 * 1024) { (metadata, error) in
                    if error != nil {
                        completion(images)
                        return
                    } else {
                        let image1 = UIImage(data: metadata!)
                        images.append(image1!)
                        let storage2 = Storage.storage().reference().child("\(directory)/\(uid)2.jpg")
                        storage2.getData(maxSize: 1 * 1024 * 1024) { (metadata, error) in
                            if error != nil {
                                completion(images)
                                return
                            } else {
                                let image1 = UIImage(data: metadata!)
                                images.append(image1!)
                                let storage3 = Storage.storage().reference().child("\(directory)/\(uid)3.jpg")
                                storage3.getData(maxSize: 1 * 1024 * 1024) { (metadata, error) in
                                    if error != nil {
                                        completion(images)
                                        return
                                    } else {
                                        let image1 = UIImage(data: metadata!)
                                        images.append(image1!)
                                        completion(images)
                                    }
                                }
                            }
                        }
                    }
                }
            }
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
    
    func getMyBusiness(uid: String, completion: @escaping (Service) -> ()) {
        let defaultService = Service(uid: "", name: "", category: "", city: "", address: "", phone: "", description: "", latitude: "", longitude: "", social: ["", "", "", "", ""], images: "0")
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
                return
//                completion(defaultService)
//                self.updateBusiness(uid: uid, name: "", category: "", city: "", address: "", phone: "", descrition: "", latitude: "", longitude: "", social: ["", "", "", "", ""], images: "0") { }
            }
        })
    }
    
    func getMyAdv(uid: String, completion: @escaping (Adv) -> ()) {
//        let defaultAdv = Adv(uid: "", name: "", category: "", city: "", price: "", phone: "", description: "", createdAt: "", images: "0")
        ref.reference(withPath: "adv").child(uid).getData(completion:  { error, snapshot in
            guard error == nil else {
                print(error!.localizedDescription)
                return;
            }
            if snapshot.exists() {
                let values = snapshot.value as! [String:Any]
                let adv = Adv(dictionary: values)
                DispatchQueue.main.async {
                    completion(adv)
                }
            } else {
                return
//                completion(defaultAdv)
//                self.updateAdv(uid: uid, name: "", category: "", city: "", price: "", phone: "", descrition: "", createdAt: "", images: "0") {}
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
        ref.reference(withPath: "messages").child(user.uid).updateChildValues([Util().dateByTimeZone() : message, "user" : user.email!])
        DispatchQueue.main.async {
            completion()
        }
    }
    
    func updateBusiness(uid: String, name: String, category: String, city: String, address: String, phone: String, descrition: String, latitude: String, longitude: String, social: [String], images: String, completion: @escaping () -> Void) {

        ref.reference(withPath: "services").child(uid).updateChildValues(["uid" : uid, "name" : name, "city" : city, "category" : category, "address" : address, "phone" : phone, "description" : descrition, "latitude": latitude, "longitude": longitude, "social": social, "images": images])
        DispatchQueue.main.async {
            completion()
        }
    }
    
    func updateAdv(uid: String, name: String, category: String, city: String, price: String, phone: String, descrition: String, images: String, updatedAt: String, isActive: String, subcategory: String, completion: @escaping () -> Void) {

        ref.reference(withPath: "adv").child(uid).updateChildValues(["uid" : uid, "name" : name, "city" : city, "category" : category, "price" : price, "phone" : phone, "description" : descrition, "images": images, "updatedAt": updatedAt, "isActive" : isActive, "subcategory" : subcategory])
        DispatchQueue.main.async {
            completion()
        }
    }
    
    func changeAdvStatus(uid: String, isActive: String, completion: @escaping () -> Void) {

        ref.reference(withPath: "adv").child(uid).updateChildValues(["isActive" : isActive])
        DispatchQueue.main.async {
            completion()
        }
    }
    
    func createAdv(uid: String, name: String, category: String, city: String, price: String, phone: String, descrition: String, createdAt: String, images: String, updatedAt: String, isActive: String, subcategory: String, completion: @escaping () -> Void) {

        ref.reference(withPath: "adv").child(uid).updateChildValues(["uid" : uid, "name" : name, "city" : city, "category" : category, "price" : price, "phone" : phone, "description" : descrition, "createdAt": createdAt, "images": images, "updatedAt": updatedAt, "isActive" : isActive, "subcategory" : subcategory])
        DispatchQueue.main.async {
            completion()
        }
    }
    
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(origin: .zero, size: newSize)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    func postImage(image: UIImage, directory: String, uid: String, quality: Double) {
        
        let storage = Storage.storage().reference().child("\(directory)/\(uid).jpg")
        
        // Resize the image to 200px in height with a custom extension
        let resizedImage = resizeImage(image: image, targetSize: CGSize(width: 1024, height: 1024))

        // Convert the image into JPEG and compress the quality to reduce its size
        let data = resizedImage!.jpegData(compressionQuality: quality)
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
    
    func deleteAccount(uid: String, completion: @escaping () -> Void) {
        deleteImage(uid: uid, directory: "avatars")
        ref.reference(withPath: "users").child(uid).removeValue()
        deleteBusiness(uid: uid)
        deleteAdv(uid: uid) {}
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
    
    func deleteBusiness(uid: String) {
        ref.reference(withPath: "services").child(uid).removeValue()
        for i in 0...4 {
            deleteImage(uid: uid + String(i), directory: "images")
        }
        
    }
    
    func deleteAdv(uid: String, completion: @escaping () -> Void) {
        ref.reference(withPath: "adv").child(uid).removeValue()
        print(uid)
        for i in 0...4 {
            deleteImage(uid: uid + "ADV" + String(i), directory: "advImages")
        }
        DispatchQueue.main.async {
            completion()
        }
    }
}
