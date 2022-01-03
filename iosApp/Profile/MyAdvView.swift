//
//  MyAdvView.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/12/23.
//

import SwiftUI

struct MyAdvView: View {
    //    @State var service: Service!
    @Binding var uid: String
    @Binding var name: String
    @Binding var city: String
    @Binding var price: String
    @Binding var phone: String
    @Binding var description: String
    @Binding var createdAt: String
    @Binding var category: String
    
    
    @State var directory: String = "advImages"
    @State private var image = UIImage(named: "blank")!
    @State private var isShowPhotoLibrary = false
    @State private var showingAlert = false
    @State private var showingAlertDelete = false
    @State private var showingHint = false
    @State private var showingHint2 = false
    @State private var businessWarning = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    
    var body: some View {
        Form {
            VStack {
                if #available(iOS 15.0, *) {
                    Image(uiImage: self.image)
                        .resizable()
                        .scaledToFill()
                        .listRowSeparator(.hidden)
                } else {
                    Image(uiImage: self.image)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                        .listRowInsets(EdgeInsets())
                        .background(Color(UIColor.systemGroupedBackground).opacity(0.1))
                    //                        .background(Color(UIColor.systemGroupedBackground))
                }
                Button("Выбрать картинку") {
                    isShowPhotoLibrary = true
                }
                .sheet(isPresented: $isShowPhotoLibrary) {
                    ImagePicker(selectedImage: self.$image, currentUid: self.$uid, directory: $directory, sourceType: .photoLibrary)
                }
                
            }
            .padding()
            HStack {
                
                Text("Название")
                    .foregroundColor(.gray)
                TextField("Название", text: $name)
                    .disableAutocorrection(true)
            }
            Picker("Категории", selection: $category) {
                Group {
                    Text("Работа").tag("work")
                    Text("Транспорт").tag("transport")
                    Text("Недвижимость").tag("house")
                    Text("Телефоны и Аксессуары").tag("phone")
                    Text("Для дома, хобби").tag("hobby")
                    Text("Автозапчасти и Аксессуары").tag("car")
                    Text("Электроника").tag("electronic")
                    Text("Детские товары").tag("children")
                    Text("Одежда").tag("clothes")
                    Text("Спорт, туризм и отдых").tag("sport")
                }
                .foregroundColor(Color("textColor"))
                Group {
                    Text("Домашние животные").tag("pet")
                    Text("Обмен, отдам бесплатно").tag("change")
                }.foregroundColor(Color("textColor"))
            }.foregroundColor(.gray)
            HStack {
                Picker("Город", selection: $city) {
                    Group {
                        Text("Ансан").tag("Ансан")
                        Text("Хвасонг").tag("Хвасонг")
                        Text("Сеул").tag("Сеул")
                        Text("Инчхон").tag("Инчхон")
                        Text("Асан").tag("Асан")
                        Text("Чхонан").tag("Чхонан")
                    }
                    .foregroundColor(Color("textColor"))
                }.foregroundColor(.gray)
                Image(systemName: "info.circle.fill")
                    .renderingMode(.original)
                    .shadow(radius: 2)
                    .onTapGesture {
                        showingHint2 = true
                    }.alert(isPresented: $showingHint2) {
                        Alert (
                            title: Text("🤔 Если Вашего города нет в списке, введите его вручную ниже"),
                            dismissButton: .default(Text("Ok"))
                        )
                    }
            }
            
            HStack {
                Text("Другой город")
                    .foregroundColor(.gray)
                TextField("", text: $city)
                    .disableAutocorrection(true)
                
            }
            HStack {
                Text("Цена/Зарплата")
                    .foregroundColor(.gray)
                TextField("", text: $price)
                    .disableAutocorrection(true)
                    
            }
            HStack {
                Text("Номер телефона")
                    .foregroundColor(.gray)
                TextField("010-0000-0000", text: $phone)
                
                
            }
            VStack {
                HStack {
                    Text("Описание:")
                }
                .foregroundColor(.gray)
                TextEditor(text: $description)
                    .frame(height: 100)
            }
            Section {
                HStack {
                    Spacer()
                    Button("Обновить данные") {
                        DB().updateAdv(uid: uid, name: name, category: category, city: city, price: price, phone: phone, descrition: description) {
                            showingAlert = true
                        }
                    }
                    Spacer()
                }.alert(isPresented: $showingAlert) {
                    Alert(
                        title: Text("Данные успешно обновлены"),
                        dismissButton: .destructive((Text("Ок")), action: {
                            presentationMode.wrappedValue.dismiss()
                        })
                    )
                }
                
            }
            
            
            
                Section {
                    HStack {
                        Spacer()
                        Button(action: {
                            showingAlertDelete = true
                        }) {
                            Text("Удалить объявление")
                                .foregroundColor(Color.red)
                        }.disabled(
                            self.name == "" &&
                            self.category == "" &&
                            self.city == "" &&
                            self.price == "" &&
                            self.phone == "" &&
                            self.description == "" &&
                            self.createdAt == ""
                        ).alert(isPresented: $showingAlertDelete) {
                            Alert(
                                title: Text("Вы уверены что хотите удалить Ваше объявление?"),
                                primaryButton: .destructive(Text("Удалить"), action: {
                                    DB().deleteAdv(uid: uid)
                                    self.name = ""
                                    self.category = ""
                                    self.city = ""
                                    self.price = ""
                                    self.phone = ""
                                    self.description = ""
                                    self.createdAt = ""
                                    presentationMode.wrappedValue.dismiss()
                                    
                                }),
                                secondaryButton: .cancel(Text("Отмена"))
                            )
                        }
                        Spacer()
                    
                }
                
            }
        }.alert(isPresented: $businessWarning) {
            Alert(
                title: Text("Создавая объявление, информация из Вашего профиля становится также доступной"),
                dismissButton: .default(Text("Ок"))
            )
        }
        
        .navigationTitle("Мои объявления")
        .onAppear {
            businessWarning = true
            if Pref.userDefault.bool(forKey: "adv") {
                businessWarning = false
            }
            Pref.userDefault.set(true, forKey: "adv")
            Pref.userDefault.synchronize()
            
            DB().getImage(uid: uid, directory: "advImages") { image in
                self.image = image
            }
        }
    }
}
