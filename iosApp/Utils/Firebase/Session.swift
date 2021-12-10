//
//  DataBase.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/12/09.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage
import UIKit
import SwiftUI

class Session: ObservableObject {

//    func down() {
//        let storage = Storage.storage()
//        let pathReference = storage.reference(withPath: "images/\(service.image[0]).jpeg").getData(maxSize: 1 * 1024 * 1024) { (imageData, err) in
//            if let err = err {
//                print("Error: \(err.localizedDescription)")
//            } else {
//                if let imageData = imageData {
//                    self.download_image = UIImage(data: imageData)
//                } else {
//                    print("no image data")
//                }
//            }
//            
//        }
//    }
    
    func download(services: [Service], completion: @escaping ([Image]) -> ()) {
        var imageArray: [Image] = []
        let storage = Storage.storage()
        
        for i in services {
            let pathReference = storage.reference(withPath: "images/\(i.image[0]).jpeg")
            pathReference.getData(maxSize: 1 * 1024 * 1024) { data, error in
              if let error = error {
                // Uh-oh, an error occurred!
                  print("// Uh-oh, an error occurred! \(error)")
              } else {
                  let image: Image = Image(uiImage: UIImage(data: data!)!)
                    print(image)
                  imageArray.append(image)
              }
                
            }
        }
        DispatchQueue.main.async {
            completion(imageArray)
        }
    }

    
    func fetchData(category: String, completion: @escaping ([Service]) -> ()) {

        let ref = Database.database(url: "https://korusale-default-rtdb.asia-southeast1.firebasedatabase.app").reference(withPath: "services")
        ref.observeSingleEvent(of: .value, with: { snapshot in
            let values = snapshot.value as! [[String:Any]]
            var innerServices: [Service] = []
            for i in values {
                let service = Service(dictionary: i)
                innerServices.append(service)
                print(service)
            }
            DispatchQueue.main.async {
                innerServices = innerServices.filter { $0.category == category }
                completion(innerServices)
            }
            
//            services = Service(dictionary: values ?? [[]])
//            let service = Service(dictionary: values ?? [:])
//            print(values)
//            let enumerator = snapshot.children
//            while let rest = enumerator.nextObject() as? DataSnapshot {
//                let values = (rest as! DataSnapshot).value as? [String:Any]
//                let service = Service(dictionary: values ?? [:])
//                self.services.append(service)
        })
        
    }
}
