//
//  WorkViewDetails.swift
//  iosApp
//
//  Created by Sergey Lee on 2022/01/26.
//
import SwiftUI

struct WorkViewDetails: View {
    @State var adv: Adv
    
    @State var service: Service = Service(uid: "", name: "", category: "", city: "", address: "", phone: "", description: "", latitude: "", longitude: "", social: ["","","","",""], images: "")
    
    @State var avatar: UIImage = UIImage(named: "avatar")!
    @State var businessImage: UIImage = UIImage(named: "logo")!
    @State var name: String = "Контактное лицо"
    @State var icon: String = ""
    @State var category: String = ""
    @State var genderString: String = ""
    @State var shiftString: String = ""
    @StateObject var serviceManager = ServiceManager()
    @StateObject var firestore = FireStore()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Group {
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
                        .lineLimit(3)
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
                        Text(adv.price)
                            .font(.system(size: 20))
                            .bold()
                            .minimumScaleFactor(0.1)
                            .padding(.leading, 15)
                    }
                    Divider()
                    HStack(spacing: 10) {
                        VStack(alignment: .leading, spacing: 10) {
                            Text(icon)
                            Text("Пол:  ")
                                .font(.body)
                                .foregroundColor(.gray)
                            Text("Смена:  ")
                                .foregroundColor(.gray)
                            Text("Возвраст:  ")
                                .foregroundColor(.gray)
                            Text("Визы:  ")
                                .foregroundColor(.gray)
                        }
                        VStack(alignment: .leading, spacing: 10) {
                            Text(category)
                                .font(.body)
                            Text(genderString)
                                .font(.body)
                            Text(shiftString)
                            if !adv.age.isEmpty {
                                Text(adv.age.joined(separator: "-") + " лет")
                            }
                            Text(adv.visa.joined(separator: ","))
                        }
                    }
                    .padding(.leading, 15).padding(.bottom, 5).padding(.trailing, 15)
                    
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
                        .padding(.vertical, 20)
                        Spacer()
                    }
                }
                if !adv.uid.contains("aaaaaaaaaaaaaaaaaaaaaaa") {
                    VStack(alignment: .leading) {
                        NavigationLink(destination: OwnerView(ownerUid: String(adv.uid.prefix(28)))) {
                            HStack {
                                UrlImageView(urlString: String(adv.uid.prefix(28)), directory: "avatars")
                                    .frame(width: 25, height: 25)
                                    .clipShape(Circle())
                                Text(self.name)
                                    .foregroundColor(Color("textColor"))
                            }
                        }
                        .padding(.bottom, 5)
                        .padding(.leading, 15)
                        
                        if service.category != "" {
                            NavigationLink(destination: ExpandedServiceDetails2(service: service, image: UIImage(named: "blank")!, count: service.images)) {
                                HStack {
                                    UrlImageView(urlString: String(adv.uid.prefix(28) + "0"), directory: "images")
                                        .frame(width: 25, height: 25)
                                        .clipShape(Circle())
                                    Text(self.service.name)
                                        .foregroundColor(Color("textColor"))
                                }
                            }
                            .padding(.bottom, 5)
                            .padding(.leading, 15)
                        }
                        
                    }.padding(.bottom, 50)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                if adv.subcategory == "factory" {
                    self.icon = "🏭"
                    self.category = "Завод"
                } else if adv.subcategory == "construction" {
                    self.icon = "👷🏻‍♀️"
                    self.category = "Стройка"
                } else if adv.subcategory == "motel" {
                    self.icon = "🏩"
                    self.category = "Мотель"
                } else if adv.subcategory == "cafe" {
                    self.icon = "🍽"
                    self.category = "Общепит"
                } else if adv.subcategory == "farm" {
                    self.icon = "🧑🏽‍🌾"
                    self.category = "Сельхоз работы"
                } else if adv.subcategory == "delivery" {
                    self.icon = "📦"
                    self.category = "Почта"
                } else if adv.subcategory == "office" {
                    self.icon = "💼"
                    self.category = "Работа в офисе"
                } else if adv.subcategory == "otherwork" {
                    self.icon = "👨‍🚀"
                    self.category = "Другая работа"
                }
                
                if adv.gender == "👱🏼‍♂️👩🏻" {
                    self.genderString = "👱🏼‍♂️ Мужчина и 👩🏻 Женщина"
                } else if adv.gender == "👱🏼‍♂️" {
                    self.genderString = "👱🏼‍♂️ Мужчина"
                } else if adv.gender == "👩🏻" {
                    self.genderString = "👩🏻 Женщина"
                }
                if adv.shift == "🌞🌚" {
                    self.shiftString = "🌞 Чуган и 🌚 Яган"
                } else if adv.shift == "🌞" {
                    self.shiftString = "🌞 Чуган"
                } else if adv.shift == "🌚" {
                    self.shiftString = "🌚 Яган"
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
            }
        }
    }
}
