//
//  AddAdv.swift
//  iosApp
//
//  Created by Sergey Lee on 2022/01/10.
//

import SwiftUI

struct AddAdvView: View {
    //    @State var service: Service!
    @State var uid: String = ""
    @State var name: String = ""
    @State var city: String = ""
    @State var price: String = ""
    @State var phone: String = ""
    @State var description: String = ""
    @State var createdAt: String = ""
    @State var category: String = ""
    
    
    @State var directory: String = "advImages"
    @State private var image = UIImage(named: "blank")!
    @State private var isShowPhotoLibrary = false
    @State private var showingAlert = false
    @State private var showingAlertDelete = false
    @State private var showingHint = false
    @State private var showingHint2 = false
    @State private var businessWarning = false
    @State private var photos: [UIImage] = []
    @State var images: String = "0"

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    
    var body: some View {
        Form {
            Section {
            if !self.photos.isEmpty {
                TabView {
                    ForEach(self.photos, id: \.self) { photo in
                        Image(uiImage: photo)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 300)
                            .cornerRadius(10)
                            .contextMenu {
                                Button(action: {
                                    self.photos = self.photos.filter { $0 != photo }
                                }) {
                                    Text("Удалить")
                                    Image(systemName: "trash")
                                }
                            }
                        
                    }
                }.frame(height: 300)
                    .indexViewStyle(.page(backgroundDisplayMode: .always))
                    .tabViewStyle(.page)
            }
                HStack {
                    Spacer()
                    Button("Выбрать изображения") {
                        isShowPhotoLibrary.toggle()
                    }
                    .sheet(isPresented: $isShowPhotoLibrary) {
                        PhotoPicker(photos: $photos, showPicker: self.$isShowPhotoLibrary, directory: "advImages", uid: uid)
                    }
                    Spacer()
                }
            
            }
            HStack {
                
                Text("UID")
                    .foregroundColor(.gray)
                TextField("UID", text: $uid)
                    .disableAutocorrection(true)
            }
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
                    Text("Автозапчасти и Аксессуары").tag("workshop")
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
                        Text("Сувон").tag("Сувон")
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
            Group {
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
            }
            Section {
                HStack {
                    Spacer()
                    Button("Обновить данные") {
                        self.images = String(photos.count)
                        DB().updateAdv(uid: uid, name: name, category: category, city: city, price: price, phone: phone, descrition: description, createdAt: Util().dateByTimeZone(), images: images) {
                            var n = 0
                            for photo1 in photos {
                                DB().postImage(image: photo1, directory: directory, uid: uid + "ADV" + String(n), quality: 0.1)
                                n += 1
                            }
                            for i in photos.count...4 {
                                print(i)
                                print("iii")
                                DB().deleteImage(uid: uid + "ADV" + String(i), directory: directory)
                            }
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
                                    DB().deleteAdv(uid: uid) {
                                        self.name = ""
                                        self.category = ""
                                        self.city = ""
                                        self.price = ""
                                        self.phone = ""
                                        self.description = ""
                                        self.createdAt = ""
                                        presentationMode.wrappedValue.dismiss()
                                    }
                                    
                                    
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
            
            DB().getMultiImages(uid: uid + "ADV", directory: directory) { images in
                self.photos = images
            }
        }
    }
}

