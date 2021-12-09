////
////  ServiceViewModel.swift
////  iosApp
////
////  Created by Sergey Lee on 2021/12/09.
////
//
//
//import Foundation
//import FirebaseFirestore
//
//class ServiceViewModel: ObservableObject {
//    
//    @Published var services = [Service]()
//    
//    private var db = Firestore.firestore()
//    
//    func fetchData() {
//        db.collection("services").addSnapshotListener { (querySnapshot, error) in
//            guard let documents = querySnapshot?.documents else {
//                print("No documents")
//                return
//            }
//            
//            self.services = documents.map { (queryDocumentSnapshot) -> Service in
//                let data = queryDocumentSnapshot.data()
//                let name = data["name"] as? String ?? ""
//                return Service(name: name)
//                
//            }
//        }
//    }
//}
