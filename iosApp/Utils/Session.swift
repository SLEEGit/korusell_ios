//
//  DataBase.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/12/09.
//

import Foundation
import FirebaseDatabase

class Session: ObservableObject {
    
    @Published var services: String?
    func fetchData() {

        
        let ref = Database.database(url: "https://korusale-default-rtdb.asia-southeast1.firebasedatabase.app").reference(withPath: "services")
        ref.observeSingleEvent(of: .value, with: { snapShot in
            let a = snapShot.value as? Dictionary<String, AnyObject>
            print(a)
        
        
//
//        .observe(.value, with: { snapshot in
//            for item in snapshot.children {
//                    print(item)
//
//            }
            
//            self.services = snapshot.value as! [Service]

        })
    }
}
//
//struct ContentView : View {
//  @StateObject private var firebaseManager = FirebaseManager()
//
//  var body : some View {
//    VStack {
//      Text("Hello, world")
//      if let result = firebaseManager.result {
//        Text(result)
//      }
//    }.onAppear {
//      firebaseManager.makeFirebaseCall()
//    }
//  }
//}
