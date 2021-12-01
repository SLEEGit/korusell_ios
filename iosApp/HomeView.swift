//
//  MainView.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/11/29.
//

import SwiftUI

struct HomeView: View {
    
    @State var list: [Work] = []
    
    var body: some View {
        
        VStack {
            HStack {
                HStack {
                    DemoView()
//                    Text("Работа")
//                    Image(systemName: "arrow.down")
                }
                .padding()
                Spacer()
                HStack {
                    Image(systemName: "filemenu.and.selection")
                    Text("Фильтр")
                }
                .padding()
            }
            List(list) { item in
                HStack {
                    Image(item.category)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                    VStack {
                        Text(item.createdAt)
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text(item.category)
                            .font(.caption)
                        HStack {
                            Text("Город:")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text(item.town)
                                .font(.caption)
                                .foregroundColor(.gray)
                            Spacer()
                            Text("Зарплата:")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text(item.salary)
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        Text(item.description)
                            .font(.caption)
                        Spacer()
                        Text(item.phone)
                            .font(.caption)
                    }
                    
                }
                
            }
            .onAppear {
                JSONParser().getWorkList(fileName: "workdata") { (list) in
                    self.list = list
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
