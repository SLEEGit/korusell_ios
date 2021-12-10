//
//  FirebaseImage.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/12/10.
//

import SwiftUI
import Combine
import FirebaseStorage

final class Loader: ObservableObject {
    let didChange = PassthroughSubject<Data?, Never>()
    var data: Data? = nil {
        didSet { didChange.send(data) }
    }
    
    init(_ id: String) {
        let url = "images/\(id).jpeg"
        let storage = Storage.storage()
        let ref = storage.reference(withPath: url)
        ref.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print("\(error)")
            }
            
            DispatchQueue.main.async {
                print("SUUUU")
                print(data)
                self.data = data
            }
        }
    }
}

//let placeholder = UIImage(named: "placeholder.jpg")!
let placeholder = UIImage(systemName: "person")!

struct FirebaseImage: View {
    
    init(id: String) {
        self.imageLoader = Loader(id)
    }
    
    @ObservedObject private var imageLoader: Loader
    
    var image: UIImage? {
        imageLoader.data.flatMap(UIImage.init)
    }
    
    var body: some View {
        Image(uiImage: image ?? placeholder)
    }
    
}
