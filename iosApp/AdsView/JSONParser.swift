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
    let town : String
    let description: String
    let phone: String
    
}


class JSONParser {

    func getWorkList(fileName: String, completion:@escaping ([Work]) -> ()) {
            guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else { return }
            URLSession.shared.dataTask(with: url) { (data, _, _) in
                let users = try! JSONDecoder().decode([Work].self, from: data!)
                print(users)
                DispatchQueue.main.async {
                    completion(users)
                }
            }
            .resume()
        }

}

