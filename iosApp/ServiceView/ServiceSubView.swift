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
            self.list = Util().getCity(city: globalCity, category: category, unsortedList: globalServices)
        }
        .navigationTitle(barTitle)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            Menu(globalCity) {
                Button("Все города") {
                    globalCity = "Все города"
                    self.list = Util().getCity(city: globalCity, category: category, unsortedList: globalServices)
                }
                Button("Ансан") {
                    globalCity = "Ансан"
                    self.list = Util().getCity(city: globalCity, category: category, unsortedList: globalServices)
                }
                Button("Хвасонг") {
                    globalCity = "Хвасонг"
                    self.list = Util().getCity(city: globalCity, category: category, unsortedList: globalServices)
                }
                Button("Инчхон") {
                    globalCity = "Инчхон"
                    self.list = Util().getCity(city: globalCity, category: category, unsortedList: globalServices)
                }
                Button("Сеул") {
                    globalCity = "Сеул"
                    self.list = Util().getCity(city: globalCity, category: category, unsortedList: globalServices)
                }
                Button("Асан") {
                    globalCity = "Асан"
                    self.list = Util().getCity(city: globalCity, category: category, unsortedList: globalServices)
                }
                Button("Чхонан") {
                    globalCity = "Чхонан"
                    self.list = Util().getCity(city: globalCity, category: category, unsortedList: globalServices)
                }
                Button("Другой город") {
                    globalCity = "Другой город"
                    self.list = Util().getCity(city: globalCity, category: category, unsortedList: globalServices)
                }
            }
        }
    }
    
}

//struct ServiceSubView_Previews: PreviewProvider {
//    static var previews: some View {
//        ServiceSubView(category: "food", menu: "service")
//    }
//}



