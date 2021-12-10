//
//  JSONParser.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/11/29.
//

import Foundation

struct Work: Codable, Identifiable {
    let id = UUID()
    let _id: String
    let createdAt: String
    let updatedAt: String
    let category: String
    let salary : String
    let visa: [String]
    let town : String
    let description: String
    let phone: String
    let image: [String]
}

struct Service: Codable, Identifiable {
    let id = UUID()
    let _id: String
    let owner: String
    let name: String
    let category: String
    let city : String
    let address : String
    let phone: String
    let image: [String]
    let description: String
    
    init(dictionary: [String: Any]) {
        self._id = dictionary["_id"] as? String ?? ""
        self.owner = dictionary["owner"] as? String ?? ""
        self.name = dictionary["name"] as? String ?? ""
        self.category = dictionary["category"] as? String ?? ""
        self.city = dictionary["city"] as? String ?? ""
        self.address = dictionary["address"] as? String ?? ""
        self.phone = dictionary["phone"] as? String ?? ""
        self.image = dictionary["image"] as? [String] ?? []
        self.description = dictionary["description"] as? String ?? ""
        }
}

struct Person: Codable, Identifiable {
    let id = UUID()
    let _id: String
    let avatar: String
    let name : String
    let username : String
    let email: String
    let phone: String
}


class JSONParser {

    func getWorkList(fileName: String, completion: @escaping ([Work]) -> ()) {
        var menu = ""
        if fileName == "zavod" || fileName == "stroyka" || fileName == "motel" || fileName == "shchiktan" || fileName == "selkhoz" || fileName == "pochta" || fileName == "ofis" || fileName == "rabota_drugoye" {
            menu = "work"
        } else {
            menu = fileName
        }
            guard let url = Bundle.main.url(forResource: menu, withExtension: "json") else { return }
            URLSession.shared.dataTask(with: url) { (data, _, _) in
                var list = try! JSONDecoder().decode([Work].self, from: data!)
                print(list)
                
                if fileName != "work" {
                    list = list.filter { $0.category == fileName }
                }
                DispatchQueue.main.async {
                    completion(list)
                }
            }
            .resume()
        }
    
    
    func getServiceList(fileName: String, completion: @escaping ([Service]) -> ()) {
            guard let url = Bundle.main.url(forResource: "service", withExtension: "json") else { return }
            URLSession.shared.dataTask(with: url) { (data, _, _) in
                var list = try! JSONDecoder().decode([Service].self, from: data!)
                print(list)

                if fileName != "service" {
                    list = list.filter { $0.category == fileName }
                }
                DispatchQueue.main.async {
                    completion(list)
                }
            }
            .resume()
        }
    
    
    func getProfiles(fileName: String, completion:@escaping ([Person]) -> ()) {
            guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else { return }
            URLSession.shared.dataTask(with: url) { (data, _, _) in
                let users = try! JSONDecoder().decode([Person].self, from: data!)
                print(users)
                DispatchQueue.main.async {
                    completion(users)
                }
            }
            .resume()
        }

}

