//
//  InnerWork.swift
//  iosApp
//
//  Created by Sergey Lee on 2022/01/27.
//

//
//  InnerAdvertisement.swift
//  iosApp
//
//  Created by Sergey Lee on 2022/01/15.
//

import SwiftUI
import MobileCoreServices

struct InnerWork: View {
    @State var adv: Adv
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
    
    @State var categoryName: String = ""
    @State var alertText: String = ""
    @State private var showingAlert2 = false
    @State var hideAdvText: String = "Скрыть объявление"
    
    @State private var photos: [UIImage] = []
//    @State var servImage = UIImage(named: "blank")!
    @State var showingAlertDelete: Bool = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @StateObject var advManager = AdvManager()
    
    @State var icon: String = ""
    @State var genderString: String = ""
    @State var shiftString: String = ""
    @StateObject var firestore = FireStore()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Group {
                    if createdAt != "" {
                        Text("Добавлено: \(Util().formatDate(date: createdAt))")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding(.bottom, 5)
                            .padding(.leading, 15)
                    }
                    Text(name)
                        .font(.title)
                        .bold()
                        .padding(.leading, 15).padding(.bottom, 5).padding(.trailing, 15)
                        .lineLimit(3)
                    if city != "admin" && adv.city != "" {
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
                        Text(price)
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
                            Text(categoryName)
                                .font(.body)
                            Text(genderString)
                                .font(.body)
                            Text(shiftString)
                            if !age.isEmpty {
                                Text(age.joined(separator: "-") + " лет")
                            }
                            Text(visa.joined(separator: ","))
                        }
                    }
                    .padding(.leading, 15).padding(.bottom, 5).padding(.trailing, 15)
                    
                    Divider()
                    if description != "" {
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
                            .padding(.trailing, 15)
                        Divider().padding(.bottom, 20)
                    }
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
                NavigationLink(destination: EditWorkView(id: $id, uid: $uid, name: $name, city: $city, price: $price, phone: $phone, description: $description, category: $category, updatedAt: $updatedAt, createdAt: $createdAt, isActive: $isActive, subcategory: $subcategory, visa: $visa, gender: $gender, shift: $shift, age: $age, photos: $photos)) {
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
                self.age = adv.age
                self.shift = adv.shift
                self.gender = adv.gender
                self.visa = adv.visa
                
                if subcategory == "factory" {
                    self.icon = "🏭"
                    self.categoryName = "Завод"
                } else if subcategory == "construction" {
                    self.icon = "👷🏻‍♀️"
                    self.categoryName = "Стройка"
                } else if subcategory == "motel" {
                    self.icon = "🏩"
                    self.categoryName = "Мотель"
                } else if subcategory == "cafe" {
                    self.icon = "🍽"
                    self.categoryName = "Общепит"
                } else if subcategory == "farm" {
                    self.icon = "🧑🏽‍🌾"
                    self.categoryName = "Сельхоз работы"
                } else if subcategory == "delivery" {
                    self.icon = "📦"
                    self.categoryName = "Почта"
                } else if subcategory == "office" {
                    self.icon = "💼"
                    self.categoryName = "Работа в офисе"
                } else if subcategory == "otherwork" {
                    self.icon = "👨‍🚀"
                    self.categoryName = "Другая работа"
                }
                
                if gender == "👱🏼‍♂️👩🏻" {
                    self.genderString = "👱🏼‍♂️ Мужчина и 👩🏻 Женщина"
                } else if gender == "👱🏼‍♂️" {
                    self.genderString = "👱🏼‍♂️ Мужчина"
                } else if gender == "👩🏻" {
                    self.genderString = "👩🏻 Женщина"
                }
                if shift == "🌞🌚" {
                    self.shiftString = "🌞 Чуган и 🌚 Яган"
                } else if shift == "🌞" {
                    self.shiftString = "🌞 Чуган"
                } else if shift == "🌚" {
                    self.shiftString = "🌚 Яган"
                }
                

                
                
                if self.isActive == "0.3" {
                    self.hideAdvText = "Восстановить объявление"
                    self.isActive = "0.3"
                    self.alertText = "Объявление скрыто"
                } else {
                    self.hideAdvText = "Скрыть объявление"
                    self.isActive = "1"
                    self.alertText = "Объявление восстановлено"
                }
            }
        }
    }
    
}

