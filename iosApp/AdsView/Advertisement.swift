//
//  Advertisement.swift
//  iosApp
//
//  Created by Sergey Lee on 2022/01/03.
//

import Foundation
import SwiftUI

struct Adv: Codable, Identifiable {
    let id = UUID()
    let uid: String
    let name: String
    let price : String
    let category: String
    let city : String
    let description: String
    let phone: String
    let createdAt: String
    let images: String
    //    let image: [String]
    
    init(dictionary: [String: Any]) {
        self.uid = dictionary["uid"] as? String ?? ""
        self.name = dictionary["name"] as? String ?? ""
        self.category = dictionary["category"] as? String ?? ""
        self.city = dictionary["city"] as? String ?? ""
        self.phone = dictionary["phone"] as? String ?? ""
        self.description = dictionary["description"] as? String ?? ""
        self.createdAt = dictionary["createdAt"] as? String ?? ""
        self.price = dictionary["price"] as? String ?? ""
        self.images = dictionary["images"] as? String ?? ""
    }
    
    init(uid: String, name: String, category: String, city: String, price: String, phone: String, description: String, createdAt: String, images: String) {
        self.uid = uid
        self.name = name
        self.category = category
        self.city = city
        self.phone = phone
        self.description = description
        self.price = price
        self.createdAt = createdAt
        self.images = images
    }
}

struct ExpandedAdv: View {
    @State var adv: Adv
    @State var image: UIImage
    
    var body: some View {
        HStack {
            //            FirebaseImage(id: "vishenka")
            UrlImageView(urlString: adv.uid + "ADV" + "0", directory: "advImages")
                .frame(width: 100, height: 100)
            //            Image(uiImage: self.image)
            //                .resizable()
            //                .scaledToFit()
            //                .onAppear {
            //                    DB().getImage(uid: service.uid, directory: "images") { image in
            //                        self.image = image
            //                    }
            //                }
            VStack(alignment: .leading) {
                Text(adv.name)
                    .font(.system(size: 16))
                    .minimumScaleFactor(0.1)
                if adv.price != "" {
                    Text("\u{20A9} \(adv.price)")
                        .font(.system(size: 16))
                        .bold()
                        .minimumScaleFactor(0.1)
                }
                
                HStack {
                    Text("Город:")
                        .font(.system(size: 13))
                        .foregroundColor(.gray)
                    Text(adv.city)
                        .font(.system(size: 13))
                        .foregroundColor(.gray)
                }
                if adv.createdAt != "" {
                    Text(Util().formatDate(date: adv.createdAt))
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding(.top, 5)
                        .lineLimit(3)
                }
            }
            .frame(width: 180)
            Spacer()
        }
    }
}


struct ExpandedAdvDetails: View {
    @State var adv: Adv
    @State var image: UIImage
    @State var isShowSheet: Bool = false
    @State var array: [Int] = [0]
    @State var newArray: [Int] = []
    @State var count: String = ""
    @State var fromAdv: Bool = false
    
    @State var service: Service = Service(uid: "", name: "", category: "", city: "", address: "", phone: "", description: "", latitude: "", longitude: "", social: ["","","","",""], images: "")
    
    @State var servImage = UIImage(named: "blank")!
    
    @State var height: CGFloat = 0
    
    
    @State var avatar: UIImage = UIImage(named: "avatar")!
    @State var businessImage: UIImage = UIImage(named: "logo")!
    @State var name: String = "Контактное лицо"
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                
                TabView {
                    ForEach(array, id: \.self) { photo in
                        UrlImageView(urlString: adv.uid  + "ADV" + String(photo), directory: "advImages")
                    }
                }
//                .padding()
                .frame(height: height)
                .cornerRadius(15)
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                .tabViewStyle(.page)
                
                Group {
                    
                    if !adv.uid.contains("aaaaaaaaaaaaaaaaaaaaaaa") {
                        VStack(alignment: .leading) {
                            NavigationLink(destination: OwnerView(ownerUid: String(adv.uid.prefix(28)))) {
                                HStack {
                                    UrlImageView(urlString: String(adv.uid.prefix(28)), directory: "avatars")
//                                    Image(uiImage: self.avatar)
//                                        .resizable()
//                                        .scaledToFill()
                                        .frame(width: 25, height: 25)
                                        .clipShape(Circle())
                                    Text(self.name)
                                        .foregroundColor(Color("textColor"))
                                    
                                }
                            }.simultaneousGesture(TapGesture().onEnded {
                                fromAdv = true
                            })
                                .padding(.bottom, 5)
                                .padding(.leading, 15)
                            
                            if service.category != "" {
                                NavigationLink(destination: ExpandedServiceDetails(service: service, image: servImage, count: service.images)) {
                                    HStack {
                                        UrlImageView(urlString: String(adv.uid.prefix(28) + "0"), directory: "images")
//                                        Image(uiImage: self.businessImage)
//                                            .resizable()
//                                            .scaledToFill()
                                            .frame(width: 25, height: 25)
                                            .clipShape(Circle())
                                        Text(self.service.name)
                                            .foregroundColor(Color("textColor"))
                                            .lineLimit(1)
                                    }
                                }
                                .simultaneousGesture(TapGesture().onEnded {
                                    fromAdv = true
                                })
                                .padding(.bottom, 5)
                                .padding(.leading, 15)
                            }
                            
                        }.padding(.bottom, 5)
                    }
                    
                if adv.createdAt != "" {
                    Text("Добавлено: \(Util().formatDate(date: adv.createdAt))")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding(.bottom, 5)
                        .padding(.leading, 15)
                }
                Text(adv.name)
                    .font(.title)
                    .bold()
                    .padding(.leading, 15).padding(.bottom, 5)
                if adv.city != "admin" && adv.city != "" {
                    HStack {
                        Text("Город")
                            .font(.body)
                            .foregroundColor(.gray)
//                        Divider()
                        Text(adv.city)
                            .font(.body)
                    }.padding(.leading, 15).padding(.bottom, 10)
                }
                
                
                if adv.price != "" {
                    Text("\u{20A9} \(adv.price)")
                        .font(.system(size: 16))
                        .bold()
                        .minimumScaleFactor(0.1)
                        .padding(.leading, 15)
                }
                Divider()
                if adv.description != "" {
                Text("Описание")
                    .font(.headline)
                    .padding(15)
                Text(adv.description)
                // эта штука снизу убрала троеточие в тексте
                    .minimumScaleFactor(0.1)
                    .font(.body)
                    .multilineTextAlignment(.leading)
                    .lineLimit(nil)
                    .padding(.horizontal, 15)
                    .padding(.bottom, 20)
                
                    Divider().padding(.bottom, 20)
                }
                }
                
                if adv.phone != "" {
                    HStack {
                        Spacer()
                        Button(action: {
                            Util().call(numberString: adv.phone)
                        }) {
                            Image(systemName: "phone.fill")
                            Text(adv.phone)
                        }
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.accentColor)
                        .cornerRadius(8)
//                        .position(x: UIScreen.main.bounds.width/2)
                        .padding(.vertical, 20)
                        Spacer()
                }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                if adv.images == "0" {
                    self.height = 0
                } else {
                    self.height = 400
                }
                DB().getMyBusiness(uid: String(adv.uid.prefix(28))) { service in
                    self.service = service
                    DB().getImage(uid: String(adv.uid.prefix(28)) + "0", directory: "images") { image in
                        self.businessImage = image
                    }
                    
                }
                DB().getUser(uid: String(adv.uid.prefix(28))) { user in
                    self.name = user.name ?? "Контактное лицо"
                    if user.name == "" {
                        self.name = "Контактное лицо"
                    }
                    DB().getImage(uid: String(adv.uid.prefix(28)), directory: "avatars") { image in
                        self.avatar = image
                    }
                }
                if fromAdv == false {
                    countToArray()
                }
                
//                sortImages() {
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//                        self.array = newArray
//                    }
//                }
            }
        }
    }
    
//    func sortImages(completion: @escaping () -> Void) {
//        self.newArray = []
//        if Int(adv.images) == 0 {
//            newArray.append(0)
//            completion()
//        } else {
//            for i in 1...Int(adv.images)! {
//                newArray.append(i-1)
//            }
//            completion()
//        }
//    }
    
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
