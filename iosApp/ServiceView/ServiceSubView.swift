//
//  ServiceSubView.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/12/04.
//

import SwiftUI
import CachedAsyncImage

struct ServiceSubView: View {
    @StateObject private var session = Session()
    @State var list: [Service] = []
    @State var afterCatlList: [Service] = []
    var category: String
    var barTitle: String = ""

    var body: some View {
        List(list) { item in
            ZStack {
                NavigationLink(destination: ServiceView(service: item)) {}
                .opacity(0.0)
                .buttonStyle(PlainButtonStyle())
                HStack {
//                    RemoteImage(url: item.image[0])
//                        .aspectRatio(contentMode: .fit)
//                    .frame(maxWidth: 100)

                    CachedAsyncImage(url: URL(string: item.image[0])) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                        } placeholder: {
                            Image(systemName: "photo")
                                .frame(width: 10, height: 10)
                                .padding()
                        }
                        

                    VStack(alignment: .leading) {
                        Text(item.name)
                            .font(.system(size: 15))
                            .bold()
                            .minimumScaleFactor(0.1)
                        HStack {
                            Text("Город:")
                                .font(.system(size: 15))
                                .foregroundColor(.gray)
                            Text(item.city)
                                .font(.system(size: 13))
                                .foregroundColor(.gray)
                        }
                        
                        Text(item.description)
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding(.top, 5)
                            .lineLimit(3)
                    }
                    Spacer()
                }
            }
        }
        .onAppear {
            self.afterCatlList = globalServices.filter { $0.category == category }
                if globalCity == "Все города" {
                    self.list = afterCatlList
                } else if globalCity == "Другой город" {
                    self.list = afterCatlList.filter { $0.city != "Чхонан" && $0.city != "Хвасонг" && $0.city != "Ансан" && $0.city != "Асан" && $0.city != "Сеул" && $0.city != "Инчхон" && $0.city != "Хвасонг"}
                } else {
                    self.list = afterCatlList.filter { $0.city == globalCity }
            }
        }
        .navigationTitle(barTitle)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            Menu {
                Button {
                    self.list = self.afterCatlList
                    globalCity = "Все города"
                } label: {
                    Text("Все города")
                }
                Button {
                    self.list = self.afterCatlList
                    globalCity = "Ансан"
                    self.list = list.filter { $0.city == globalCity }
                } label: {
                    Text("Ансан")
                }
                Button {
                    self.list = self.afterCatlList
                    globalCity = "Хвасонг"
                    self.list = list.filter { $0.city == globalCity }
                } label: {
                    Text("Хвасонг")
                }
                Button {
                    self.list = self.afterCatlList
                    globalCity = "Инчхон"
                    self.list = list.filter { $0.city == globalCity }
                } label: {
                    Text("Инчхон")
                }
                Button {
                    self.list = self.afterCatlList
                    globalCity = "Сеул"
                    self.list = list.filter { $0.city == globalCity }
                } label: {
                    Text("Сеул")
                }
                Button {
                    self.list = self.afterCatlList
                    globalCity = "Асан"
                    self.list = list.filter { $0.city == globalCity }
                } label: {
                    Text("Асан")
                }
                Button {
                    self.list = self.afterCatlList
                    globalCity = "Чхонан"
                    self.list = list.filter { $0.city == globalCity }
                } label: {
                    Text("Чхонан")
                }
                Button {
                    self.list = self.afterCatlList
                    globalCity = "Другой город"
                    self.list = list.filter { $0.city != "Чхонан" && $0.city != "Хвасонг" && $0.city != "Ансан" && $0.city != "Асан" && $0.city != "Сеул" && $0.city != "Инчхон" && $0.city != "Хвасонг"}
                } label: {
                    Text("Другой город")
                }
            } label: {
                //                Image(systemName: "eye.circle")
                Text(globalCity)
            }
        }
    }
    
}

//struct ServiceSubView_Previews: PreviewProvider {
//    static var previews: some View {
//        ServiceSubView(category: "food", menu: "service")
//    }
//}



