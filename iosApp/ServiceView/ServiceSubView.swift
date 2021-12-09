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
            let icon = Util().parseCategory(category: item.category)[0]
            let name = Util().parseCategory(category: item.category)[1]
            
            ZStack {
                NavigationLink(destination: ServiceView(service: item)) {}
                .opacity(0.0)
                .buttonStyle(PlainButtonStyle())
                HStack {
                    if item.image != [] {
                        Image(item.image[0])
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(10)
                        
                    } else {
                        Text(icon)
                    }
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
                }
            }
        }
        .onAppear {
            session.fetchData()
            if let result = session.services {
                print(result)
            }
            JSONParser().getServiceList(fileName: menu) { (list) in
                self.list = list
                self.unsortedList = list
            }
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

struct ServiceSubView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceSubView(category: "food", menu: "service")
    }
}



