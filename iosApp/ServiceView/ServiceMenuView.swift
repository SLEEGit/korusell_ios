//
//  TestView.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/12/01.
//

import SwiftUI

struct ServiceMenuView: View {
    
    @ObservedObject var fetcher = DataFetcher()
    @State private var city = "Все города"
    
    var body: some View {
        NavigationView {
            List(fetcher.serviceItem) { item in
                ZStack {
                    NavigationLink(destination: ServiceSubView(city: city, category: item.category, barTitle: item.image + " " + item.name, menu: item.category)) {}
                    .opacity(0.0)
                    .buttonStyle(PlainButtonStyle())
                    HStack{
                        Text(item.image)
                            .font(.title)
                        Text(item.name)
                        Spacer()
                    }
                }
            }.navigationTitle("Услуги")
                .toolbar{
                    Menu {
                        Button {
                            
                            city = "Все города"
                        } label: {
                            Text("Все города")
                        }
                        Button {
                            
                            city = "Ансан"
                            
                        } label: {
                            Text("Ансан")
                        }
                        Button {
                            
                            city = "Хвасонг"
                            
                        } label: {
                            Text("Хвасонг")
                        }
                        Button {
                            
                            city = "Инчxон"
                            
                        } label: {
                            Text("Инчxон")
                        }
                        Button {
                            
                            city = "Сеул"
                            
                        } label: {
                            Text("Сеул")
                        }
                        Button {
                            
                            city = "Асан"
                            
                        } label: {
                            Text("Асан")
                        }
                        Button {
                            
                            city = "Чхонан"
                            
                        } label: {
                            Text("Чхонан")
                        }
                        Button {
                            
                            city = "Другой город"
                       
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
}

struct ServiceMenuView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceMenuView()
    }
}
