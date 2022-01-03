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
    var social: [String] = ["", "", "", "", ""]
    
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
        self.social = dictionary["social"] as? [String] ?? []
    }
    
    init(uid: String, name: String, category: String, city: String, address: String, phone: String, description: String, latitude: String, longitude: String, social: [String]) {
        self.uid = uid
        self.name = name
        self.category = category
        self.city = city
        self.address = address
        self.phone = phone
        self.description = description
        self.latitude = latitude
        self.longitude = longitude
        self.social = social
    }
}

struct ExpandedService: View {
    @State var service: Service
    @State var image: UIImage
    var body: some View {
        HStack {
            //            FirebaseImage(id: "vishenka")
            UrlImageView(urlString: service.uid)
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
        ScrollView {
            VStack(alignment: .leading) {
                UrlImageView(urlString: service.uid)
                    .scaledToFill()
                    .cornerRadius(15)
                    .padding()
                Text(service.name)
                    .font(.title)
                    .bold()
                    .padding(.leading, 15)
                HStack {
                    Text("Город")
                        .font(.body)
                        .foregroundColor(.gray)
                    Divider()
                    Text(service.city)
                        .font(.body)
                }.padding(.leading, 15)
                HStack {
                    Text("Адрес")
                        .font(.body)
                        .foregroundColor(.gray)
                        .padding(.bottom, 15)
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
                        .font(.body)
                }.padding(.horizontal, 15)
                
                Divider()
                Text("Описание")
                    .font(.headline)
                    .padding(15)
                Text(service.description)
                    .font(.body)
                    .multilineTextAlignment(.leading)
                    .lineLimit(nil)
                    .padding(.horizontal, 15)
                    .padding(.bottom, 20)
                // эта штука снизу убрала троеточие в тексте
                    .minimumScaleFactor(0.1)
                
                if service.phone != "" {
                    Group {
                        Divider().padding(.bottom, 20)
                        Button(action: {
                            Util().call(numberString: service.phone)
                        }) {
                            Image(systemName: "phone.fill")
                            Text(service.phone)
                        }
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.accentColor)
                        .cornerRadius(8)
                    }.position(x: UIScreen.main.bounds.width/2)
                        .padding(.vertical, 20)
                        
                }
                
                HStack(spacing: 30) {
                    Spacer()
                    if service.social[0] != "" {
                        Link(destination: URL(string: service.social[0])!, label: {
                                Image("facebook")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                        })
                    }
                    if service.social[1] != "" {
                        Link(destination: URL(string: service.social[1])!, label: {
                                Image("instagram")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                        })
                    }
                    if service.social[2] != "" {
                        Link(destination: URL(string: service.social[2])!, label: {
                                Image("telegram")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                        })
                    }
                    if service.social[3] != "" {
                        Link(destination: URL(string: service.social[3])!, label: {
                                Image("youtube")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                        })
                    }
                    if service.social[4] != "" {
                        Link(destination: URL(string: service.social[4])!, label: {
                                Image("webpage")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                        })
                    }
                    Spacer()
                }.padding(.bottom, 30)
                
                
                
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
                        }.padding(30)
                        .sheet(isPresented: $isShowSheet) {
                            OwnerView(ownerUid: service.uid)
                        }
                    }
                }
            }
        }
    }
}
