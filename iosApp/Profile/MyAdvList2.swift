//
//  MyAdvList2.swift
//  iosApp
//
//  Created by Sergey Lee on 2022/01/14.
//

import SwiftUI
import FirebaseAuth

struct MyAdvList2: View {
    @StateObject private var session = DB()
    @State var list: [Adv] = []
    @State var isLoading: Bool = true
    @State var showingAlertDelete: Bool = false
    
    var myUID: String = ""
    @State var newUid: String = ""
    @State var uid: String = ""
    @State var name: String = ""
    @State var phone: String = ""
    @State var city: String = ""
    @State var address: String = ""
    @State var description: String = ""
    @State var price: String = ""
    @State var createdAt: String = ""
    @State var category: String = ""
    @State private var photos: [UIImage] = []
    
    @Binding var count: Int
    
    var body: some View {
        ZStack {
            List {
                Section {
                    if list.count != 0 {
                        Text("Нажмите и удерживайте объявление, чтобы удалить")
                    } else {
                        Text("Нажмите 'Добавить', чтобы добавить объявление")
                    }
                }
                    .padding()
                    .foregroundColor(Color("graytext"))
                    .font(.system(size: 15))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .listRowInsets(EdgeInsets())
                    .background(Color(UIColor.systemGroupedBackground).opacity(0.1))
                    .background(Color(UIColor.systemGroupedBackground))
                
                ForEach(self.list, id: \.id) { adv in
                    NavigationLink(destination: InnerAdvertisement(adv: adv)) {
                        MyAdvView2(post: adv)
                            .contextMenu {
                                Button(action: {
                                    showingAlertDelete = true
                                }) {
                                    HStack {
                                        Image(systemName: "trash")
                                        Text("Удалить")
                                    }
                                }
                            }.alert(isPresented: $showingAlertDelete) {
                                Alert(
                                    title: Text("Вы уверены что хотите удалить Ваше объявление?"),
                                    primaryButton: .destructive(Text("Удалить"), action: {
                                        DB().deleteAdv(uid: adv.uid) {
                                            session.getAdvs(category: "all") { (list) in
                                                self.list = list.filter { $0.uid.contains(myUID) }
                                                                .sorted { $0.createdAt > $1.createdAt }
                                                count = self.list.count
                                            }
                                        }
                                    }),
                                    secondaryButton: .cancel(Text("Отмена"))
                                )
                            }
                    }
                }
            }
                .navigationTitle("Мои Объявления")
                .onAppear {
                    self.newUid = self.myUID + Util().dateForAdv(date: Util().dateByTimeZone())
                        session.getAdvs(category: "all") { (list) in
                            self.list = list.filter { $0.uid.contains(myUID) }
                                            .sorted { $0.createdAt > $1.createdAt }
                            count = self.list.count
                            self.isLoading = false
                        }

                }
            .disabled(isLoading)
            if isLoading {
                ProgressView().progressViewStyle(CircularProgressViewStyle(tint: Color("textColor")))
                    .background(Color(UIColor.systemGroupedBackground).opacity(0.1))
            }
        }
        .navigationBarItems(trailing:
                NavigationLink(destination: EditAdvView(uid: $newUid, name: $name, city: $city, price: $price, phone: $phone, description: $description, createdAt: $createdAt, category: $category, photos: $photos)) {
                    Text("Добавить")
                }
            
                
        )
    }
    
}

struct MyAdvView2: View {
    let post: Adv
    @State var imagename: String = "launchicon_mini"
    @State var image: UIImage = UIImage(named: "launchicon_mini")!
    
    var body: some View {
        HStack(alignment: .top) {
//            UrlImageView(urlString: post.uid  + "ADV" + "0", directory: "advImages")
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
            VStack(alignment: .leading) {
                Text(Util().formatDate(date: post.createdAt))
                    .padding(.leading, 16).padding(.bottom, 5)
                    .font(.caption)
                    .foregroundColor(Color.gray)
                Text(post.name)
                    .lineLimit(5)
                    .font(.headline)
                //                    .font(.system(size: 15))
                    .padding(.leading, 4).padding(.trailing, 4).padding(.bottom, 4)
                Text(post.description)
                    .lineLimit(5)
                    .font(.caption)
                    .padding(.leading, 4).padding(.trailing, 4).padding(.bottom, 4)
            }.frame(height: 150, alignment: .leading)
                .onAppear {
                    DB().getImage(uid: post.uid + "ADV" + "0", directory: "advImages") { image in
                        self.image = image
                    }
                }
        }
    }
    
    //        var body: some View {
    //            VStack(alignment: .leading, spacing: 8) {
    //                UrlImageView(urlString: post.uid + "0", directory: "advImages")
    //                    .frame(height: 250)
    ////                    .scaledToFit()
    //
    ////                    .clipped()
    //                Text(Util().formatDate(date: post.createdAt))
    //                    .padding(.leading, 16).padding(.bottom, 5)
    //                    .font(.caption)
    //                    .foregroundColor(Color.gray)
    //                HStack {
    //                    Text(post.name).font(.headline)
    //                }
    //                .padding(EdgeInsets(top: 8, leading: 16, bottom: 0, trailing: 0))
    //
    //                Text(post.description)
    //                    .lineLimit(3)
    //                    .font(.system(size: 15))
    //                    .padding(.leading, 16).padding(.trailing, 16).padding(.bottom, 16)
    //            }
    //            .listRowInsets(EdgeInsets())
    //        }
}

