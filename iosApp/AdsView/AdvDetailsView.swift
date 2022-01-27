//
//  AdvDetailsView.swift
//  iosApp
//
//  Created by Sergey Lee on 2022/01/03.
//

import SwiftUI
import MobileCoreServices

struct AdvDetailsView: View {
    var adv: Adv!
    
    @State var array: [Int] = []
    @State private var image = UIImage(named: "blank")!
    
    var body: some View {
        ExpandedAdvDetails(adv: adv, image: image, count: adv.images)
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
    
    @StateObject var serviceManager = ServiceManager()
    @StateObject var firestore = FireStore()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                
                TabView {
                    ForEach(array, id: \.self) { photo in
                        NavigationLink(destination: FullScreenImages(imagename: adv.uid  + "ADV", count: count)) {
                            UrlImageView(urlString: adv.uid  + "ADV" + String(photo), directory: "advImages")
                                .scaledToFit()
                        }
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
                            }
                                .padding(.bottom, 5)
                                .padding(.leading, 15)
                            
                            if service.category != "" {
                                NavigationLink(destination: ExpandedServiceDetails2(service: service, image: servImage, count: service.images)) {
                                    HStack {
                                        UrlImageView(urlString: String(adv.uid.prefix(28) + "0"), directory: "images")
//                                        Image(uiImage: self.businessImage)
//                                            .resizable()
//                                            .scaledToFill()
                                            .frame(width: 25, height: 25)
                                            .clipShape(Circle())
                                        Text(self.service.name)
                                            .foregroundColor(Color("textColor"))
//                                            .lineLimit(1)
                                    }
                                }
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
                    .padding(.leading, 15).padding(.bottom, 5).padding(.trailing, 15)
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
                    .padding(.trailing, 15)
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
                        .cornerRadius(15)
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
                serviceManager.getMyService() { service in
                    self.service = service
                    DB().getImage(uid: String(adv.uid.prefix(28)) + "0", directory: "images") { image in
                        self.businessImage = image
                    }
                    
                }
                
                firestore.getUser(uid: String(adv.uid.prefix(28))) { user in
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
                    fromAdv = true
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
