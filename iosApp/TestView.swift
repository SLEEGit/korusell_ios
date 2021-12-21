//
//  TestView.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/12/21.
//


import SwiftUI
import UIKit
//import SDWebImageSwiftUI
import FirebaseStorage
import CachedAsyncImage

struct Profile {
    let id: String
    let name: String
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}

struct TestView: View {

        let profile: Profile
        @State var urlString: String = ""
        var body: some View {
            VStack {
                CachedAsyncImage(url: URL(string: self.urlString))
//                    .resizable()
//                    .placeholder {
//                        Image("profile")
//                            .resizable()
//                }
//                .animation(.easeInOut(duration: 0.5))
//                .transition(.fade)
//                .scaledToFill()

                VStack {
                    Spacer()
                    Text(profile.name)
                        .font(Font.system(size: 20.0).bold())
                        .frame(maxWidth: .infinity, maxHeight: 32)
                        .background(Color.gray)
                        .foregroundColor(Color.white)
                        .opacity(0.8)
                }
            }.onAppear {
                self.featchImageUrl()
            }
        }

        func featchImageUrl() {
            let storage = Storage.storage()
            let pathReference = storage.reference(withPath: "images/\(profile.id)/.jpg")
            pathReference.downloadURL { url, error in
                if let error = error {
                    // Handle any errors
                    print(error)
                } else {
                    guard let urlString = url?.absoluteString else {
                        return
                    }
                    self.urlString = urlString
                }
            }
        }
    }

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView(profile: Profile(id: "assorti.logo", name: "Name1"))
    }
}
