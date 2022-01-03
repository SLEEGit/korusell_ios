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
    }
    
    init(uid: String, name: String, category: String, city: String, price: String, phone: String, description: String, createdAt: String) {
        self.uid = uid
        self.name = name
        self.category = category
        self.city = city
        self.phone = phone
        self.description = description
        self.price = price
        self.createdAt = createdAt
    }
}

struct ExpandedAdv: View {
    @State var adv: Adv
    @State var image: UIImage
    
    var body: some View {
        HStack {
            //            FirebaseImage(id: "vishenka")
            UrlImageView(urlString: adv.uid, directory: "advImages")
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
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                UrlImageView(urlString: adv.uid, directory: "advImages")
                    .scaledToFill()
                    .cornerRadius(15)
                    .padding()
                if adv.createdAt != "" {
                    Text("Добавлено: \(Util().formatDate(date: adv.createdAt))")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding(.bottom, 10)
                        .padding(.leading, 15)
                }
                Text(adv.name)
                    .font(.title)
                    .bold()
                    .padding(.leading, 15)
                HStack {
                    Text("Город")
                        .font(.body)
                        .foregroundColor(.gray)
                    Divider()
                    Text(adv.city)
                        .font(.body)
                }.padding(.leading, 15)
                if adv.price != "" {
                    Text("\u{20A9} \(adv.price)")
                        .font(.system(size: 16))
                        .bold()
                        .minimumScaleFactor(0.1)
                        .padding(.leading, 15)
                }
                Divider()
                Text("Описание")
                    .font(.headline)
                    .padding(15)
                Text(adv.description)
                    .font(.body)
                    .multilineTextAlignment(.leading)
                    .lineLimit(nil)
                    .padding(.horizontal, 15)
                    .padding(.bottom, 20)
                // эта штука снизу убрала троеточие в тексте
                    .minimumScaleFactor(0.1)
                
                if adv.phone != "" {
                    Group {
                        Divider().padding(.bottom, 20)
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
                    }.position(x: UIScreen.main.bounds.width/2)
                        .padding(.vertical, 20)
                    
                }

                
                if adv.uid.count > 10 {
                    Section {
                        Button(action: {
                            isShowSheet = true
                        }) {
                            HStack(alignment: .center) {
                                Spacer()
                                Image(systemName: "person.crop.circle")
                                Text("Контактное лицо")
                                Spacer()
                            }
                        }.padding(20)
                        .sheet(isPresented: $isShowSheet) {
                            OwnerView(ownerUid: adv.uid)
                        }
                    }
                }
            }
        }
    }
}
