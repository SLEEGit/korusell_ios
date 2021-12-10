//
//  DataBase.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/12/09.
//

import FirebaseDatabase

class Session: ObservableObject {
    
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
