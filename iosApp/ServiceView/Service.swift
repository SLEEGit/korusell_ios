//
//  Service.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/12/20.
//

import Foundation
import SwiftUI

struct Service: Codable, Identifiable {
    
    let id = UUID()
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
    let images: String
    
    init(dictionary: [String: Any]) {
//        self.id = UUID()
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
        self.images = dictionary["images"] as? String ?? ""
    }
    
    init(id: String, uid: String, name: String, category: String, city: String, address: String, phone: String, description: String, latitude: String, longitude: String, social: [String], images: String) {
//        self.id = id
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
        self.images = images
    }
}

struct ExpandedService: View {
    @State var service: Service
    @State var image: UIImage
    var body: some View {
        HStack {
            UrlImageView(urlString: service.uid + "0", directory: "images")
                .scaledToFit()
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
//            .frame(width: 180)
            Spacer()
        }
    }
}


struct ExpandedServiceDetails: View {
    @State var service: Service
    @State var image: UIImage
    @State var isShowSheet: Bool = false
    @State var addressCopy: Bool = false
    @State var array: [Int] = [0]
    @State var arrayIm: [UIImage] = []
    @State var newArray: [Int] = []
    @State var count: String = ""
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                //                if !self.arrayIm.isEmpty {
                TabView {
                    ForEach(array, id: \.self) { photo in
                        UrlImageView(urlString: service.uid + String(photo), directory: "images")
                            .scaledToFit()
                        //                            Image(uiImage: photo)
                        //                                .resizable()
                        //                                .scaledToFit()
                        //                                .frame(height: 300)
                            .cornerRadius(10)
                    }
                }
                .padding()
                .frame(height: 350)
                .cornerRadius(15)
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                .tabViewStyle(.page)
                //                } else {
                //                    Image("blank")
                //                        .padding()
                //                        .frame(height: 350)
                //                        .cornerRadius(15)
                //
                //                }
                //                UrlImageView(urlString: service.uid, directory: "images")
                //                    .scaledToFill()
                //                    .cornerRadius(15)
                //                    .padding()
                Group {
                    Text(service.name)
                        .font(.title)
                        .bold()
                        .padding(.leading, 15).padding(.trailing, 15)
                    HStack {
                        Text("Город")
                            .font(.body)
                            .foregroundColor(.gray)
                        
                        //                    Divider()
                        Text(service.city)
                            .font(.body)
                        
                    }.padding(.leading, 15)
                        .padding(.bottom, 10)
                        .padding(.top, 10)
                    if service.address != "" {
                        HStack {
                            Text("Адрес")
                                .font(.body)
                                .foregroundColor(.gray)
                            //                        .padding(.bottom, 15)
                            //                        .padding(.trailing, 30)
                            //                        Divider()
                            Text(service.address)
                                .font(.body)
                            
                            Button(action: {
                                UIPasteboard.general.string = service.address
                                addressCopy = true
                            }) {
                                Image(systemName: "doc.on.doc")
                            }.alert(isPresented: $addressCopy) {
                                Alert (
                                    title: Text("Адрес скопирован"),
                                    dismissButton: .default(Text("Ok"))
                                )
                            }
                            
                        }.padding(.leading, 15)
                            .padding(.trailing, 15)
                            .padding(.bottom, 15)
                    }
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
                }
                Divider().padding(.bottom, 20)
                if service.phone != "" {
                    HStack {
                        Spacer()
                        Button(action: {
                            Util().call(numberString: service.phone)
                        }) {
                            Image(systemName: "phone.fill")
                            Text(service.phone)
                        }
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.accentColor)
                        .cornerRadius(15)
                        Spacer()
                    }
                    //                    .position(x: UIScreen.main.bounds.width/2)
                    .padding(.vertical, 20)
                    
                }
                
                HStack(spacing: 30) {
                    Spacer()
                    if service.social[0] != "" && service.social[0] != "https://www.facebook.com/" {
                        Link(destination: URL(string: service.social[0]) ?? URL(string: "https://www.facebook.com/")!, label: {
                            Image("facebook")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                        })
                    }
                    if service.social[1] != "" && service.social[1] != "https://www.instagram.com/" {
                        Link(destination: URL(string: service.social[1]) ?? URL(string: "https://www.instagram.com/")!, label: {
                            Image("instagram")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                        })
                    }
                    if service.social[2] != "" && service.social[2] != "https://t.me/" {
                        Link(destination: URL(string: service.social[2]) ?? URL(string: "https://t.me/")!, label: {
                            Image("telegram")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                        })
                    }
                    if service.social[3] != "" && service.social[3] != "https://www.youtube.com/" {
                        Link(destination: URL(string: service.social[3]) ?? URL(string: "https://www.youtube.com/")! , label: {
                            Image("youtube")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                        })
                    }
                    if service.social[4] != "" && service.social[4] != "https://" {
                        Link(destination: URL(string: service.social[4]) ?? URL(string: "https://")!, label: {
                            Image("webpage")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                        })
                    }
                    Spacer()
                }.padding(.bottom, 30)
                
                
                
                if !service.uid.contains("aaaaaaaaaaaaaaaaaaaaaaa") {
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
            .onAppear {
                countToArray()
                //                sortImages() {
                //                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                //                        self.array = newArray
                //                    }
                //                }
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
    
    //    func sortImages(completion: @escaping () -> Void) {
    //        self.newArray = []
    //        if Int(service.images) == 0 {
    //            newArray.append(0)
    //            completion()
    //        } else {
    //            for i in 1...Int(service.images)! {
    //                newArray.append(i-1)
    //            }
    //            completion()
    //        }
    //    }
}
