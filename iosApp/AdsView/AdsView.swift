////
////  MenuView.swift
////  iosApp
////
////  Created by Sergey Lee on 2021/11/30.
////
//
//import SwiftUI
//
//struct AdsView: View {
//    @ObservedObject var fetcher = DataFetcher()
////    @State var workCount: String = ""
//    var body: some View {
//        NavigationView {
//            List(fetcher.menuItem, children: \.children){ item in
//                ZStack {
//                    NavigationLink(destination: AdsSubView(category: item.category, barTitle: item.image + " " + item.name, menu: item.category )) {}
//                    .opacity(0.0)
//                    .buttonStyle(PlainButtonStyle())
//                    HStack{
//                        Text(item.image)
//                            .font(.title)
//                        Text(item.name)
//                        Spacer()
////                        Text(String(workCount))
//                        
//                    }
//                }
//            }
////            .onAppear {
////                JSONParser().getWorkList(fileName: item) { (list) in
////                    workCount = String(list.count) }
////            }
//            .navigationTitle("Объявления")
////                .toolbar{
////                        NavigationLink(destination: InformationView()) {
////                        Text("info")
////                    }
////                }
//  
//        }
//    }
//}
//
//
//struct AdsView_Previews: PreviewProvider {
//    static var previews: some View {
//        AdsView()
//    }
//}
