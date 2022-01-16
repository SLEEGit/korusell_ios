//
//  InnerAdvertisement.swift
//  iosApp
//
//  Created by Sergey Lee on 2022/01/15.
//

import SwiftUI
import MobileCoreServices

struct InnerAdvertisement: View {
    var adv: Adv!
    
    @State var array: [Int] = []
    @State private var images: [UIImage] = [UIImage(named: "blank")!]
    
    var body: some View {
        ExpandedAdvDetails2(adv: adv, images: images, count: adv.images)
    }
    
    
}


struct ExpandedAdvDetails2: View {
    @State var adv: Adv
    @State var images: [UIImage]
    @State var isShowSheet: Bool = false
    @State var array: [Int] = [0]
    @State var newArray: [Int] = []
    @State var count: String = ""
    @State var fromAdv: Bool = false

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
//    @State var servImage = UIImage(named: "blank")!
    @State var showingAlertDelete: Bool = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if !self.photos.isEmpty {
                    TabView {
                        ForEach(self.photos, id: \.self) { photo in
                            Image(uiImage: photo)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 400)
                                .cornerRadius(10)
                        }
                    }
                     
                     .frame(height: 400)
                     .indexViewStyle(.page(backgroundDisplayMode: .always))
                     .tabViewStyle(.page)
                     .padding(.leading, 8)
                } else {
                    Image("launchicon_mini")
                        .resizable()
                        .scaledToFit()
//                    ProgressView().progressViewStyle(CircularProgressViewStyle(tint: Color("textColor")))
//                        .background(Color(UIColor.systemGroupedBackground).opacity(0.1))
                        .frame(width: 400, height: 400, alignment: .center)
                        .padding(.leading, 8)
                }
//                .padding()
//                .frame(height: 400)
//                .cornerRadius(15)
//                .indexViewStyle(.page(backgroundDisplayMode: .always))
//                .tabViewStyle(.page)
                Group {
                    if createdAt != "" {
                        Text("Добавлено: \(Util().formatDate(date: createdAt))")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding(.bottom, 10)
                            .padding(.leading, 15)
                    }
                    Text(name)
                        .font(.title)
                        .bold()
                        .padding(.leading, 15)
                    if city != "admin" && city != "" {
                        HStack {
                            Text("Город")
                                .font(.body)
                                .foregroundColor(.gray)
                            //                        Divider()
                            Text(city)
                                .font(.body)
                        }.padding(.leading, 15).padding(.bottom, 10)
                    }
                    
                    
                    if price != "" {
                        Text("\u{20A9} \(price)")
                            .font(.system(size: 16))
                            .bold()
                            .minimumScaleFactor(0.1)
                            .padding(.leading, 15)
                    }
                    Divider()
                    Text("Описание")
                        .font(.headline)
                        .padding(15)
                    Text(description)
                    // эта штука снизу убрала троеточие в тексте
                        .minimumScaleFactor(0.1)
                        .font(.body)
                        .multilineTextAlignment(.leading)
                        .lineLimit(nil)
                        .padding(.horizontal, 15)
                        .padding(.bottom, 20)
                    
                    Divider().padding(.bottom, 20)
                }
                
                if phone != "" {
                    HStack {
                        Spacer()
                        Button(action: {
//                            Util().call(numberString: phone)
                        }) {
                            Image(systemName: "phone.fill")
                            Text(phone)
                        }
//                        .foregroundColor(.white)
                        .padding()
//                        .background(Color.accentColor)
                        .cornerRadius(8)
                        .padding(.vertical, 20)
                        Spacer()
                    }
                }
                NavigationLink(destination: EditAdvView(uid: $uid, name: $name, city: $city, price: $price, phone: $phone, description: $description, createdAt: $createdAt, category: $category, photos: $photos)) {
                    HStack {
                        Spacer()
                        HStack {
                            Image(systemName: "pencil")
                            Text("Редактировать")
                                .bold()
                        }
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.accentColor)
                        .cornerRadius(10)
                        .padding(.vertical, 20)
                        Spacer()
                    }
                    
                }
                
                HStack {
                    Spacer()
                            Button(action: {
                                showingAlertDelete = true
                            }) {
                                HStack {
                                    Image(systemName: "trash")
                                    Text("Удалить")
                                        .bold()
                                   
                                }
                            }.alert(isPresented: $showingAlertDelete) {
                            Alert(
                                title: Text("Вы уверены что хотите удалить Ваше объявление?"),
                                primaryButton: .destructive(Text("Удалить"), action: {
                                    DB().deleteAdv(uid: adv.uid) {
                                        DB().getAdvs(category: "all") { (list) in
                                            globalAdv = list.sorted { $0.createdAt > $1.createdAt }
                                            presentationMode.wrappedValue.dismiss()
                                        }
                                    }
                                }),
                                secondaryButton: .cancel(Text("Отмена"))
                            )
                        }
                        .foregroundColor(Color.white)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(10)
                        .padding(.vertical, 20)
                    Spacer()
                }
            }
//            .navigationBarItems(trailing:
//                    NavigationLink(destination: EditAdvView(uid: $uid, name: $name, city: $city, price: $price, phone: $phone, description: $description, createdAt: $createdAt, category: $category, photos: $photos)) {
//                        Text("Редактировать")
//                    })
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                self.uid = adv.uid
                
                DB().getMyAdv(uid: self.uid) { adv in
                    self.name = adv.name
                    self.phone = adv.phone
                    self.city = adv.city
                    self.price = adv.price
                    self.description = adv.description
                    self.createdAt = adv.createdAt
                    self.category = adv.category
                    self.count = adv.images
                }
                DB().getMultiImages(uid: uid + "ADV", directory: "advImages") { images in
                    self.photos = images
                }

                if fromAdv == false {
                    countToArray()
                }
            }
        }
    }
    
    func countToArray() {
        if let int = Int(count) {
            if int != 0 && int != 1 {
                for i in 2...int {
                    array.append(i-1)
                }
            }
            
        }
    }
}
