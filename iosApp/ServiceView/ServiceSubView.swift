//
//  ServiceSubView.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/12/04.
//

import SwiftUI

struct ServiceSubView: View {
    @StateObject private var session = Session()
    @State var list: [Service] = []
    @State var unsortedList: [Service] = []
    @State private var showingSheet = false
    @State private var city = "Все города"
    
    var category: String
    var barTitle: String = ""
    var menu: String
    
    var body: some View {
        List(list) { item in
            
            ZStack {
                NavigationLink(destination: ServiceView(service: item)) {}
                .opacity(0.0)
                .buttonStyle(PlainButtonStyle())
                HStack {
                    RemoteImage(url: item.image[0])
                        .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: 100)
//                    AsyncImage(url: URL(string: item.image[0])) { image in
//                            image
//                                .resizable()
//                                .scaledToFit()
//                        } placeholder: {
//
//                            Image("")
//                        }
//                        .frame(width: 100, height: 100)
//
                    VStack(alignment: .leading) {
                        Text(item.name)
                            .font(.title2)
                        HStack {
                            Text("Город:")
                                .font(.system(size: 15))
                                .foregroundColor(.gray)
                            Text(item.city)
                                .font(.system(size: 15))
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
            session.fetchData(category: menu) { (list) in
                self.list = list
                self.unsortedList = list
            }
//            JSONParser().getServiceList(fileName: menu) { (list) in
//
//            }
        }
        .navigationTitle(barTitle)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            Menu {
                Button {
                    self.list = self.unsortedList
                    city = "Все города"
                } label: {
                    Text("Все города")
                }
                Button {
                    self.list = self.unsortedList
                    city = "Ансан"
                    self.list = list.filter { $0.city == city }
                } label: {
                    Text("Ансан")
                }
                Button {
                    self.list = self.unsortedList
                    city = "Хвасонг"
                    self.list = list.filter { $0.city == city }
                } label: {
                    Text("Хвасонг")
                }
                Button {
                    self.list = self.unsortedList
                    city = "Инчхон"
                    self.list = list.filter { $0.city == city }
                } label: {
                    Text("Инчхон")
                }
                Button {
                    self.list = self.unsortedList
                    city = "Сеул"
                    self.list = list.filter { $0.city == city }
                } label: {
                    Text("Сеул")
                }
                Button {
                    self.list = self.unsortedList
                    city = "Асан-Синчанг"
                    self.list = list.filter { $0.city == city }
                } label: {
                    Text("Асан-Синчанг")
                }
                Button {
                    self.list = self.unsortedList
                    city = "Чхонан"
                    self.list = list.filter { $0.city == city }
                } label: {
                    Text("Чхонан")
                }
                Button {
                    self.list = self.unsortedList
                    city = "Другой город"
                    self.list = list.filter { $0.city != "Чхонан" && $0.city != "Хвасонг" && $0.city != "Ансан" && $0.city != "Асан-Синчанг" && $0.city != "Сеул" && $0.city != "Инчхон" && $0.city != "Хвасонг"}
                } label: {
                    Text("Другой город")
                }
            } label: {
                //                Image(systemName: "eye.circle")
                Text(city)
            }
        }
    }
    
}

//struct ServiceSubView_Previews: PreviewProvider {
//    static var previews: some View {
//        ServiceSubView(category: "food", menu: "service")
//    }
//}



