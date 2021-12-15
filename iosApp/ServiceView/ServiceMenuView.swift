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
    @State var selectCategory: Bool = false
    
    var body: some View {
        
        NavigationView {
            
            List(fetcher.serviceItem) { item in
                
                ZStack {
                    
                    NavigationLink(destination: ServiceSubView(category: item.category, barTitle: item.image + " " + item.name)) {}
                    .opacity(0.0)
                    .buttonStyle(PlainButtonStyle())
                    HStack{
                        Text(item.image)
                            .font(.title)
                        Text(item.name)
                        Spacer()
                    }
                }
                
            }
            .onAppear{
                city = globalCity
            }
            .navigationTitle("Услуги")
            .toolbar{
                Menu {
                    Button {
                        globalCity = "Все города"
                        city = globalCity
                    } label: {
                        Text("Все города")
                    }
                    Button {
                        globalCity = "Ансан"
                        city = globalCity
                    } label: {
                        Text("Ансан")
                    }
                    Button {
                        globalCity = "Хвасонг"
                        city = globalCity
                    } label: {
                        Text("Хвасонг")
                    }
                    Button {
                        globalCity = "Инчхон"
                        city = globalCity
                    } label: {
                        Text("Инчхон")
                    }
                    Button {
                        globalCity = "Сеул"
                        city = globalCity
                    } label: {
                        Text("Сеул")
                    }
                    Button {
                        globalCity = "Асан"
                        city = globalCity
                    } label: {
                        Text("Асан")
                    }
                    Button {
                        globalCity = "Чхонан"
                        city = globalCity
                    } label: {
                        Text("Чхонан")
                    }
                    Button {
                        globalCity = "Другой город"
                        city = globalCity
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
