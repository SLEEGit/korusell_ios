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
//    @State var list: [Adv] = []
    @StateObject var advManager = AdvManager()
    @State var isLoading: Bool = true
    @State var showingAlertDelete: Bool = false
    
    @State var myUID: String
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
    @State var updatedAt: String = ""
    @State var isActive: String = ""
    @State var subcategory: String = "subcategory"
    
    @State private var photos: [UIImage] = []
    
    @Binding var count: Int
    
    var body: some View {
        ZStack {
            List {
                Section {
                    if count != 0 {
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
                
                ForEach(advManager.myAdvs, id: \.uid) { adv in
                    NavigationLink(destination: InnerAdvertisement(adv: adv)) {
                        MyAdvView2(adv: adv)
                            .opacity(Double(adv.isActive)!)
                            .contextMenu {
                                Button(action: {
                                    showingAlertDelete = true
                                }) {
                                    HStack {
                                        Image(systemName: "trash")
                                        Text("Удалить")
                                    }
                                }
                                
                            }
                            .alert(isPresented: $showingAlertDelete) {
                                Alert(
                                    title: Text("Вы уверены что хотите удалить Ваше объявление?"),
                                    primaryButton: .destructive(Text("Удалить"), action: {
                                        advManager.deleteAdv(uid: adv.uid) {}
//                                        DB().deleteAdv(uid: adv.uid) {
//                                            DB().getAdvs(category: "all") { (list) in
////                                                globalAdv = list.sorted { $0.createdAt > $1.createdAt }
////                                                self.list = globalAdv.filter { $0.uid.contains(myUID) }
////                                                count = self.list.count
//                                            }
//                                        }
                                    }),
                                    secondaryButton: .cancel(Text("Отмена"))
                                )
                            }
                    }
                }
            }
                .navigationTitle("Мои Объявления")
                .onAppear {
                    print("UID::: \(myUID)")
                    
                    advManager.getMyAdvs()
                            count = advManager.myAdvs.count
                            self.isLoading = false
                }
            .disabled(isLoading)
            if isLoading {
                ProgressView().progressViewStyle(CircularProgressViewStyle(tint: Color("textColor")))
                    .background(Color(UIColor.systemGroupedBackground).opacity(0.1))
            }
        }
        .navigationBarItems(trailing:
                                NavigationLink(destination: NewAdvView(uid: $myUID, name: $name, city: $city, price: $price, phone: $phone, description: $description, category: $category, updatedAt: $updatedAt, isActive: $isActive, subcategory: $subcategory, photos: $photos)) {
                    Text("Добавить")
                }
            
                
        )
    }
    
}

struct MyAdvView2: View {
    let adv: Adv
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
                Text(Util().formatDate(date: adv.createdAt))
                    .padding(.leading, 4).padding(.trailing, 4).padding(.bottom, 3).padding(.top, 2)
                    .font(.caption)
                    .foregroundColor(Color.gray)
                Text(adv.name)
                    .lineLimit(2)
                    .font(.headline)
                    .padding(.leading, 4).padding(.trailing, 4).padding(.bottom, 2)
                Text(adv.city)
                    .foregroundColor(Color.gray)
                    .lineLimit(5)
                    .font(.caption)
                    .padding(.leading, 4).padding(.trailing, 4).padding(.bottom, 2)
                Text(adv.price)
                    .font(.title3)
            }.frame(height: 150, alignment: .leading)
                .onAppear {
                    DB().getImage(uid: adv.uid + "ADV" + "0", directory: "advImages") { image in
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

