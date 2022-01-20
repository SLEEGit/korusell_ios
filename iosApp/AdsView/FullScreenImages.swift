//
//  FullScreenImages.swift
//  iosApp
//
//  Created by Sergey Lee on 2022/01/19.
//

import SwiftUI

struct FullScreenImages: View {
    var imagename: String
    var count: String
    @State var array: [Int] = [0]
    
    @State var scale: CGFloat = 1.0
    
    var body: some View {
        TabView {
            ForEach(array, id: \.self) { photo in
                    UrlImageView(urlString: imagename + String(photo), directory: "advImages")
                    .scaleEffect(scale)
                    .gesture(MagnificationGesture()
                                .onChanged { value in
                        self.scale = value.magnitude
                        
                    }.onEnded {_ in self.scale = 1.0}
                             
                    )
                        .scaledToFit()
            }
        }
//        .frame(height: height)
//        .cornerRadius(15)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        .tabViewStyle(.page)
        .onAppear {
            countToArray()
        }
    }
    
    func countToArray() {
        if let int = Int(count) {
            if int != 0 && int != 1 {
                for i in 2...int {
                    array.append(i-1)
                }
            }
            
        }
    }
    
}

struct FullScreenImages_Previews: PreviewProvider {
    static var previews: some View {
        FullScreenImages(imagename: "", count: "")
    }
}
