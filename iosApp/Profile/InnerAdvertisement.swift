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
    @StateObject var advManager = AdvManager()
    
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

    @State var id = UUID()
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
    @State var subcategory: String = ""
    @State var visa: [String] = []
    @State var gender: String = ""
    @State var shift: String = ""
    @State var age: [String] = []
    
    @State var alertText: String = ""
    @State private var showingAlert2 = false
    @State var hideAdvText: String = "Скрыть объявление"
    
    @State private var photos: [UIImage] = []
//    @State var servImage = UIImage(named: "blank")!
    @State var showingAlertDelete: Bool = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @StateObject var advManager = AdvManager()
    
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
                            .padding(.leading, 30)
                            
                    }
                    Text(name)
                        .font(.title)
                        .bold()
                        .padding(.leading, 30).padding(.bottom, 10)
                    if city != "admin" && city != "" {
                        HStack {
                            Text("Город")
                                .font(.body)
                                .foregroundColor(.gray)
                            //                        Divider()
                            Text(city)
                                .font(.body)
                        }.padding(.leading, 30).padding(.bottom, 10)
                    }
                    
                    
                    if price != "" {
                        Text("\u{20A9} \(price)")
                            .font(.system(size: 16))
                            .bold()
                            .minimumScaleFactor(0.1)
                            .padding(.leading, 30)
                    }
                    Divider()
                    Text("Описание")
                        .font(.headline)
                        .padding(30)
                    Text(description)
                    // эта штука снизу убрала троеточие в тексте
                        .minimumScaleFactor(0.1)
                        .font(.body)
                        .multilineTextAlignment(.leading)
                        .lineLimit(nil)
                        .padding(.horizontal, 30)
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
                        .cornerRadius(15)
                        .padding(.vertical, 15)
                        Spacer()
                    }
                }
                NavigationLink(destination: EditAdvView(id: $id, uid: $uid, name: $name, city: $city, price: $price, phone: $phone, description: $description, category: $category, updatedAt: $updatedAt, createdAt: $createdAt, isActive: $isActive, subcategory: $subcategory, visa: $visa, gender: $gender, shift: $shift, age: $age, photos: $photos)) {
                    HStack {
                        Spacer()
                        HStack {
//                            Image(systemName: "pencil")
                            Text("Редактировать")
                                .bold()
                        }
                        .foregroundColor(Color.accentColor)
                        .padding()
                        .background(Color("graybg"))
                        .cornerRadius(15)
                        .padding(.vertical, 10)
                        Spacer()
                    }
                    
                }
                HStack {
                    Spacer()
                            Button(action: {
                                if self.isActive == "0.3" {
                                    self.hideAdvText = "Восстановить объявление"
                                    self.isActive = "1"
                                    self.alertText = "Объявление восстановлено"
                                } else {
                                    self.hideAdvText = "Скрыть объявление"
                                    self.isActive = "0.3"
                                    self.alertText = "Объявление скрыто"
                                }
                                advManager.changeAdvStatus(uid: uid, isActive: self.isActive) {
                                    self.showingAlert2 = true
                                }
//                                DB().changeAdvStatus(uid: uid, isActive: self.isActive) {
//                                    self.showingAlert2 = true
//                                }
                            }) {
                                HStack {
//                                    Image(systemName: "trash")
                                    Text(self.hideAdvText)
                                        .bold()
                                   
                                }
                            }.alert(isPresented: $showingAlert2) {
                                Alert(
                                    title: Text(alertText),
                                    dismissButton: .destructive((Text("Ок")), action: {
                                        presentationMode.wrappedValue.dismiss()
                                    })
                                )
                        }
                        .foregroundColor(Color.accentColor)
                        .padding()
                        .background(Color("graybg"))
                        .cornerRadius(15)
                        .padding(.vertical, 10)
                    Spacer()
                }
                
                HStack {
                    Spacer()
                            Button(action: {
                                showingAlertDelete = true
                            }) {
                                HStack {
//                                    Image(systemName: "trash")
                                    Text("Удалить")
                                        .bold()
                                   
                                }
                            }.alert(isPresented: $showingAlertDelete) {
                            Alert(
                                title: Text("Вы уверены что хотите удалить Ваше объявление?"),
                                primaryButton: .destructive(Text("Удалить"), action: {
                                    advManager.deleteAdv(uid: adv.uid) {
                                        presentationMode.wrappedValue.dismiss()
                                    }
                                }),
                                secondaryButton: .cancel(Text("Отмена"))
                            )
                        }
                        .foregroundColor(Color.red)
                        .padding()
                        .background(Color("graybg"))
                        .cornerRadius(15)
                        .padding(.vertical, 10)
                    Spacer()
                }
                
            }
//            .navigationBarItems(trailing:
//                    NavigationLink(destination: EditAdvView(uid: $uid, name: $name, city: $city, price: $price, phone: $phone, description: $description, createdAt: $createdAt, category: $category, photos: $photos)) {
//                        Text("Редактировать")
//                    })
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                self.id = adv.id
                self.uid = adv.uid
                self.name = adv.name
                self.phone = adv.phone
                self.city = adv.city
                self.price = adv.price
                self.description = adv.description
                self.createdAt = adv.createdAt
                self.category = adv.category
                self.count = adv.images
                self.isActive = adv.isActive
                self.subcategory = adv.subcategory
                self.updatedAt = adv.updatedAt
                
                

                
//                DB().getMyAdv(uid: self.uid) { adv in
//                    self.name = adv.name
//                    self.phone = adv.phone
//                    self.city = adv.city
//                    self.price = adv.price
//                    self.description = adv.description
//                    self.createdAt = adv.createdAt
//                    self.category = adv.category
//                    self.count = adv.images
//                    self.isActive = adv.isActive
//                    self.subcategory = adv.subcategory
//                    self.updatedAt = self.updatedAt
                    
                    if self.isActive == "0.3" {
                        self.hideAdvText = "Восстановить объявление"
                        self.isActive = "0.3"
                        self.alertText = "Объявление скрыто"
                    } else {
                        self.hideAdvText = "Скрыть объявление"
                        self.isActive = "1"
                        self.alertText = "Объявление восстановлено"
                    }
//                }
                DB().getMultiImages(uid: uid + "ADV", directory: "advImages") { images in
                    self.photos = images
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
