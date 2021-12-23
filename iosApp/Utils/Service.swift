//
//  Service.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/12/20.
//

import Foundation
import SwiftUI

struct Service: Codable, Identifiable {
    
    var id = UUID()
    let uid: String
    let name: String
    let category: String
    let city : String
    let address : String
    let phone: String
    let description: String
    let latitude: String
    let longitude: String
    
    init(dictionary: [String: Any]) {
        self.uid = dictionary["uid"] as? String ?? ""
        self.name = dictionary["name"] as? String ?? ""
        self.category = dictionary["category"] as? String ?? ""
        self.city = dictionary["city"] as? String ?? ""
        self.address = dictionary["address"] as? String ?? ""
        self.phone = dictionary["phone"] as? String ?? ""
        self.description = dictionary["description"] as? String ?? ""
        self.latitude = dictionary["latitude"] as? String ?? ""
        self.longitude = dictionary["longitude"] as? String ?? ""
    }
    
    init(uid: String, name: String, category: String, city: String, address: String, phone: String, description: String, latitude: String, longitude: String) {
        self.uid = uid
        self.name = name
        self.category = category
        self.city = city
        self.address = address
        self.phone = phone
        self.description = description
        self.latitude = latitude
        self.longitude = longitude
    }
}

struct ExpandedService: View {
    @State var service: Service
    @State var image: UIImage
    var body: some View {
        HStack {
            //            FirebaseImage(id: "vishenka")
            UrlImageView(urlString: service.uid)
            //            Image(uiImage: self.image)
            //                .resizable()
            //                .scaledToFit()
            //                .onAppear {
            //                    DB().getImage(uid: service.uid, directory: "images") { image in
            //                        self.image = image
            //                    }
            //                }
            VStack(alignment: .leading) {
                Text(service.name)
                    .font(.system(size: 15))
                    .bold()
                    .minimumScaleFactor(0.1)
                HStack {
                    Text("Город:")
                        .font(.system(size: 15))
                        .foregroundColor(.gray)
                    Text(service.city)
                        .font(.system(size: 13))
                        .foregroundColor(.gray)
                }
                
                Text(service.description)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.top, 5)
                    .lineLimit(3)
            }
            .frame(width: 180)
            Spacer()
        }
    }
}


struct ExpandedServiceDetails: View {
    @State var service: Service
    @State var image: UIImage
    @State var isShowSheet: Bool = false
    var body: some View {
        Form {
            UrlImageView(urlString: service.uid)
            //            Image(uiImage: image)
            //                .resizable()
                .scaledToFit()
            //                .onAppear {
            //                    DB().getImage(uid: service.uid, directory: "images") { image in
            //                        self.image = image
            //                    }
            //                }
            Section {
                
                Text(service.name)
                    .font(.title3)
                
                HStack {
                    Text("Город")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Divider()
                    Text(service.city)
                        .font(.caption)
                }
                HStack {
                    Text("Адрес")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Divider()
                    Text(service.address)
                        .contextMenu {
                            Button(action: {
                                UIPasteboard.general.string = service.address
                            }) {
                                Text("Скопировать")
                                Image(systemName: "doc.on.doc")
                            }
                        }
                        .font(.caption)
                }

                Text(service.description)
                    .font(.caption)
                    .multilineTextAlignment(.leading)
                    .lineLimit(nil)
                    .padding(.bottom, 10)
                // эта штука снизу убрала троеточие в тексте
                    .minimumScaleFactor(0.1)
                
            }
            
            Section {
                Button(action: {
                    Util().call(numberString: service.phone)
                }) {
                    HStack(alignment: .center) {
                        Spacer()
                        Image(systemName: "phone.fill")
                        Text(service.phone)
                        Spacer()
                    }
                }
            }
            if service.uid.count > 10 {
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
                    }.sheet(isPresented: $isShowSheet) {
                        OwnerView(ownerUid: service.uid)
                    }
                }
            }
        }
    }
}
