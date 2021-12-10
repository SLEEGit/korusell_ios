//
//  Storage.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/12/10.
//

import Foundation
import FirebaseStorage
import UIKit
import SwiftUI

class StorageImage {
    
    
    func download() {
        let Ref = Storage.storage().reference(forURL: "gs://korusale.appspot.com/images/relax.jpeg")
        Ref.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if error != nil {
                print("Error: Image could not download!")
            } else {
                let image = UIImage(data: data!)
                print(image)
            }
        }
    }
    
    func listItem() {
        let storage = Storage.storage()
        // Create a reference
        let storageRef = storage.reference().child("images")
        
        // Create a completion handler - aka what the function should do after it listed all the items
        let handler: (StorageListResult, Error?) -> Void = { (result, error) in
            if let error = error {
                print("error", error)
            }
            
            let item = result.items
            print("item: ", item)
        }
        
        // List the items
        storageRef.list(maxResults: 10, completion: handler)
    }
    
    //    func download(image: String, completion: @escaping (UIImage) -> ()) {
    //        var image = UIImage()
    //        let storage = Storage.storage()
    //        let pathReference = storage.reference(withPath: "images/relax.jpeg")
    //        pathReference.getData(maxSize: 1 * 1024 * 1024) { data, error in
    //          if let error = error {
    //            // Uh-oh, an error occurred!
    //              print("// Uh-oh, an error occurred! \(error)")
    //          } else {
    //              let image1 = UIImage(data: data!)!
    //                print(image)
    //                image = image1
    //              DispatchQueue.main.async {
    //                  print("SUCCESS")
    //                  completion(image1)
    //              }
    //          }
    //        }
    //    }
    
    func upload() {
        let storageRef = Storage.storage().reference()
        
        // Local file you want to upload
        let localFile = URL(string: "images/relax")!
        
        // Create the file metadata
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        // Upload file and metadata to the object 'images/mountains.jpg'
        let uploadTask = storageRef.putFile(from: localFile, metadata: metadata)
        
        // Listen for state changes, errors, and completion of the upload.
        uploadTask.observe(.resume) { snapshot in
            // Upload resumed, also fires when the upload starts
        }
        
        uploadTask.observe(.pause) { snapshot in
            // Upload paused
        }
        
        uploadTask.observe(.progress) { snapshot in
            // Upload reported progress
            let percentComplete = 100.0 * Double(snapshot.progress!.completedUnitCount)
            / Double(snapshot.progress!.totalUnitCount)
        }
        
        uploadTask.observe(.success) { snapshot in
            print("SUCCESS")
            print(snapshot)
            // Upload completed successfully
        }
        
        uploadTask.observe(.failure) { snapshot in
            if let error = snapshot.error as? NSError {
                switch (StorageErrorCode(rawValue: error.code)!) {
                case .objectNotFound:
                    // File doesn't exist
                    print("File doesn't exists")
                    break
                case .unauthorized:
                    print("// User doesn't have permission to access file")
                    // User doesn't have permission to access file
                    break
                case .cancelled:
                    print("// User canceled the upload")
                    // User canceled the upload
                    break
                    
                    /* ... */
                    
                case .unknown:
                    // Unknown error occurred, inspect the server response
                    print("// Unknown error occurred, inspect the server response")
                    break
                default:
                    print("// A separate error occurred. This is a good place to retry the upload.")
                    // A separate error occurred. This is a good place to retry the upload.
                    break
                }
            }
        }
    }
    
    
    
    func loadImageFromFirebase(filename: String, completion: @escaping (URL) -> ()) {
        //        storage = Storage.storage(app:customApp, url:"gs://my-custom-bucket")
        
        let url1 = Storage.storage().reference(withPath: "images/relax.jpeg")
        url1.downloadURL { (url, error) in
            if error != nil {
                print((error?.localizedDescription)!)
                print("FAIL")
                return
            }
            DispatchQueue.main.async {
                print("SUCCESS")
                completion(url!)
            }
        }
        
        
    }
    
    //    func loadImageFromFirebase(filename: String, completion: @escaping (URL) -> ()) {
    ////        storage = Storage.storage(app:customApp, url:"gs://my-custom-bucket")
    //
    //        let url1 = Storage.storage().reference(withPath: "images/relax.jpeg")
    //        url1.downloadURL { (url, error) in
    //            if error != nil {
    //                print((error?.localizedDescription)!)
    //                print("FAIL")
    //                return
    //            }
    //            DispatchQueue.main.async {
    //                print("SUCCESS")
    //                completion(url!)
    //            }
    //        }
    //}
    
    
    
}

