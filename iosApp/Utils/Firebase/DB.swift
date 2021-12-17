//
//  DataBase.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/12/09.
//

import FirebaseDatabase
import FirebaseAuth

class DB: ObservableObject {
    
//    GET
    func fetchData(category: String, completion: @escaping ([Service]) -> ()) {

        let ref = Database.database(url: "https://korusale-default-rtdb.asia-southeast1.firebasedatabase.app").reference(withPath: "services")
        ref.observeSingleEvent(of: .value, with: { snapshot in
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

        let ref = Database.database(url: "https://korusale-default-rtdb.asia-southeast1.firebasedatabase.app").reference(withPath: "users")
        ref.child(uid).getData(completion:  { error, snapshot in
          guard error == nil else {
            print(error!.localizedDescription)
            return;
          }
            print(snapshot)
            print(snapshot.value)
            let values = snapshot.value as! [String:Any]
            let user = User(dictionary: values)
            completion(user)
        });
        
    }
    
//    POST
    func createUserInDB(user: FirebaseAuth.User, completion: @escaping () -> Void) {

        let ref = Database.database(url: "https://korusale-default-rtdb.asia-southeast1.firebasedatabase.app").reference(withPath: "users")
        ref.child(user.uid).setValue(["uid" : user.uid, "email" : user.email, "name" : "", "phone" : ""])
            DispatchQueue.main.async {
                completion()
            }
    }
    
    func addNamePhone(user: FirebaseAuth.User, name: String, phone: String, completion: @escaping () -> Void) {

        let ref = Database.database(url: "https://korusale-default-rtdb.asia-southeast1.firebasedatabase.app").reference(withPath: "users")
        ref.child(user.uid).updateChildValues(["name" : name, "phone" : phone])
            DispatchQueue.main.async {
                completion()
            }
    }
    

}
