//
//  Filter.swift
//  iosApp
//
//  Created by Sergey Lee on 2022/01/14.
//


import SwiftUI

//struct Filter: View {
//    
//    @ObservedObject var fetcher = DataFetcher()
//    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
//    @Binding var emoji: String
//    @Binding var category: String
//    @Binding var list: [Adv]
//    var city: String
//    var body: some View {
//        List(fetcher.menuItem) { item in
//            ZStack {
//                HStack{
//                    Text(item.image)
//                        .font(.title)
//                    Text(item.name)
//                    Spacer()
//                }
//                Spacer()
//            }
//            .contentShape(Rectangle())
//            .frame(maxWidth: .infinity)
//            .onTapGesture {
//                self.emoji = item.image
//                self.category = item.category
//                globalAdvCategory = item.category
//                self.list = Util().filterAdv(city: city, category: category, unsortedList: globalAdv)
//                presentationMode.wrappedValue.dismiss()
//            }
//        }
//        .navigationTitle("Категории")
//        .navigationBarTitleDisplayMode(.inline)
//        .onAppear{
//        }
//    }
//}

