//
//  TestView.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/12/01.
//

import SwiftUI
import FirebaseAuth

var globalServices: [Service] = []
var globalCity: String = "Все города"
var globalCategory: String = "all"

struct ServiceMenuView: View {
    
    
    @ObservedObject var fetcher = DataFetcher()
    @State private var city = "Все города"
    @State var selectCategory: Bool = false
    @State var isLoading: Bool = true
    @State var isShowInfo: Bool = false
    @State var email: String = ""
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        
        ZStack {
            
            NavigationView {
                List(fetcher.serviceItem) { item in
                    NavigationLink(destination: ServiceSubView(category: item.category, barTitle: item.image + " " + item.name)) {
                        HStack{
                            Text(item.image)
                                .font(.title)
                            Text(item.name)
                            Spacer()
                        }
                    }
                }
                .navigationBarItems(leading:
                                        NavigationLink(destination: getDestination()) {
                    if colorScheme == .dark {
                        Image("logo_blue_line")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 20)
                    } else {
                        Image("logo_blue_line")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 20)
                            .shadow(color: Color.gray, radius: 1, x: 1, y: 1)
                    }
                    
                })
                .navigationTitle("Услуги")
                .onAppear{
                    
                    email = Auth.auth().currentUser?.email ?? ""
                    city = globalCity
                        self.isLoading = false
                }
                
                .navigationBarItems(trailing:
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
                        globalCity = "Сувон"
                        city = globalCity
                    } label: {
                        Text("Сувон")
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
                        globalCity = "Чхонджу"
                        city = globalCity
                    } label: {
                        Text("Чхонджу")
                    }
                    Group {
                        Button {
                            globalCity = "Пхёнтхэк"
                            city = globalCity
                        } label: {
                            Text("Пхёнтхэк")
                        }
                        Button {
                            globalCity = "Сосан"
                            city = globalCity
                        } label: {
                            Text("Сосан")
                        }
                        Button {
                            globalCity = "Дунпо"
                            city = globalCity
                        } label: {
                            Text("Дунпо")
                        }
                        Button {
                            globalCity = "Другой город"
                            city = globalCity
                        } label: {
                            Text("Другой город")
                        }
                    }
                    
                } label: {
                    //                Image(systemName: "eye.circle")
                    Text(city)
                        .font(.system(size: 15))
                        .minimumScaleFactor(0.1)
                }
                )
                
            }.disabled(isLoading)
            if isLoading {
                ProgressView().progressViewStyle(CircularProgressViewStyle(tint: Color("textColor")))
                    .background(Color(UIColor.systemGroupedBackground).opacity(0.1))
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    
    func getDestination() -> AnyView {
        if email == "guagetru.bla@inbox.ru" {
            return AnyView(AdminPanelView())
        } else {
            return AnyView(Text("🥚 ver. 1.4"))
        }
    }
}

struct ServiceMenuView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceMenuView()
    }
}



