//
//  ImageCache.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/12/21.
//

import Foundation
import SwiftUI

struct UrlImageView: View {
    @ObservedObject var urlImageModel: UrlImageModel
    
    init(urlString: String?, directory: String?) {
        urlImageModel = UrlImageModel(urlString: urlString, directory: directory)
    }
    
    var body: some View {
        Image(uiImage: urlImageModel.image ?? UrlImageView.defaultImage!)
            .resizable()
            .scaledToFit()
//            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
//            .listRowInsets(EdgeInsets())
//            .background(Color(UIColor.systemGroupedBackground))
    }
    
    static var defaultImage = UIImage(named: "launchicon_mini")
}

class UrlImageModel: ObservableObject {
    @Published var image: UIImage?
    var urlString: String?
    var directory: String?
    var imageCache = ImageCache.getImageCache()
    
    init(urlString: String?, directory: String?) {
        self.urlString = urlString
        self.directory = directory
        loadImage()
    }
    
    func loadImage() {
        if loadImageFromCache() {
            return
        }
        loadImageFromUrl()
    }
    
    func loadImageFromCache() -> Bool {
        
            guard let urlString = urlString else {
                return false
            }
            
            guard let cacheImage = imageCache.get(forKey: urlString) else {
                return false
            }
            
            image = cacheImage
            return true
        }
    
    func loadImageFromUrl() {
        guard let urlString = urlString else {
            return
        }
        guard let directory = directory else {
            return
        }

        
        
        DB().getImage(uid: urlString, directory: directory) { img in
            self.getImageFromResponse(loadedImage: img, response: nil, error: nil)
            self.image = img
        }
    }
    
    
    func getImageFromResponse(loadedImage: UIImage?, response: URLResponse?, error: Error?) {
        guard error == nil else {
            print("Error: \(error!)")
            return
        }
        guard let loadedImage = loadedImage else {
            print("No data found")
            return
        }
        
        DispatchQueue.main.async {
//            guard let loadedImage = image else {
//                print("image  not loaded")
//                return
//            }
//            print("image  loaded")
            self.imageCache.set(forKey: self.urlString!, image: loadedImage)
            self.image = loadedImage
        }
    }
}


class ImageCache {
    var cache = NSCache<NSString, UIImage>()
    
    func get(forKey: String) -> UIImage? {
        return cache.object(forKey: NSString(string: forKey))
    }
    
    func set(forKey: String, image: UIImage) {
        cache.setObject(image, forKey: NSString(string: forKey))
    }
}

extension ImageCache {
    private static var imageCache = ImageCache()
    static func getImageCache() -> ImageCache {
        return imageCache
    }
}
