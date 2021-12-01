//
//  MenuView.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/11/30.
//

import SwiftUI

//struct MenuView: View {
//    var body: some View {
//        List(sampleMenuItems, children: \.subMenuItems) { item in
//
//            HStack {
//                    Image(item.image)
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 50, height: 50)
//
//                    Text(item.name)
//                        .font(.system(.title3, design: .rounded))
//                        .bold()
//
//                }
//        }
//    }
//}

struct MenuView: View {
    @ObservedObject var fetcher = DataFetcher()
    var body: some View {
        List(fetcher.menuItem, children: \.children){
            item in
                HStack{
                    Text(item.image)
                        .font(.title)
//                    Image(item.image)
//                        .resizable()
//                        .frame(width: 30, height: 30)
                        
                    Text(item.name)
                }
        }
    }
}


struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
