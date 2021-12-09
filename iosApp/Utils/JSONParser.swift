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

