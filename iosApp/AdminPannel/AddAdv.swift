//
//  AddAdv.swift
//  iosApp
//
//  Created by Sergey Lee on 2022/01/27.
//

import SwiftUI

struct AddAdv: View {
    //    @State var service: Service!
    @State var uid: String = ""
    @State var name: String = ""
    @State var city: String = ""
    @State var price: String = ""
    @State var phone: String = ""
    @State var description: String = ""
    @State var category: String = ""
    @State var updatedAt: String = ""
    @State var isActive: String = ""
    @State var subcategory: String = ""
    @State var visa: [String] = []
    @State var gender: String = ""
    @State var shift: String = ""
    @State var age: [String] = []
    
    @State var directory: String = "advImages"
    @State private var image = UIImage(named: "blank")!
    @State private var isShowPhotoLibrary = false
    @State private var showingAlert = false
    @State private var showingAlertDelete = false
    @State private var showingHint = false
    @State private var showingHint2 = false
    @State private var businessWarning = false
    @State var photos: [UIImage] = []
    @State var images: String = "0"
    @State var checked: Bool = false
    
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
            } else {
                Image("launchicon_mini")
                    .resizable()
                    .scaledToFill()
//                    ProgressView().progressViewStyle(CircularProgressViewStyle(tint: Color("textColor")))
//                        .background(Color(UIColor.systemGroupedBackground).opacity(0.1))
//                    .frame(width: 350, height: 300)
                    .clipped()
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
            Group {
            HStack {
                
                Text("UID")
                    .foregroundColor(.gray)
                TextField("UID", text: $uid)
                    .disableAutocorrection(true)
            }
            HStack {
                
                Text("Заголовок")
                    .foregroundColor(.gray)
                TextField("Название", text: $name)
                    .disableAutocorrection(true)
            }
            Picker("Категории", selection: $category) {
                Group {
//                    Text("🛠 Работа").tag("work")
                    Text("🚗 Транспорт").tag("transport")
                    Text("🏢 Недвижимость").tag("house")
                    Text("📱 Телефоны и Аксессуары").tag("phone")
                    Text("🏠 Для дома, хобби").tag("hobby")
                    Text("⚙️ Автозапчасти и Аксессуары").tag("car")
                    Text("📺 Электроника").tag("electronic")
                    Text("👶🏻 Детские товары").tag("children")
                    Text("👕 Одежда").tag("clothes")
                    Text("🏓 Спорт, туризм и отдых").tag("sport")
                }
                .foregroundColor(Color("textColor"))
                Group {
                    Text("🐶 Домашние животные").tag("pet")
                    Text("🔄 Обмен, отдам бесплатно").tag("change")
                    Text("🪆 Другое").tag("other")
                }.foregroundColor(Color("textColor"))
            }.foregroundColor(.gray)
            
//            if self.category == "work" {
//                Picker("Виды работ", selection: $subcategory) {
//                    Group {
//                        Text("🏭 Завод").tag("factory")
//                        Text("👷🏻‍♀️ Стройка").tag("construction")
//                        Text("🏩 Мотель").tag("motel")
//                        Text("🍽 Общепит").tag("cafe")
//                        Text("🧑🏽‍🌾 Сельхоз работы").tag("farm")
//                        Text("📦 Почта/Доставка").tag("delivery")
//                        Text("💼 Работа в офисе").tag("office")
//                        Text("👨‍🚀 Другая работа").tag("otherwork")
//                    }.foregroundColor(Color("textColor"))
//                }
//                .foregroundColor(.gray)
//            }
            
            
            HStack {
                Picker("Город", selection: $city) {
                    Group {
                        Text("Ансан").tag("Ансан")
                        Text("Хвасонг").tag("Хвасонг")
                        Text("Сеул").tag("Сеул")
                        Text("Сувон").tag("Сувон")
                        Text("Инчхон").tag("Инчхон")
                        Text("Асан").tag("Асан")
                        Text("Чхонан").tag("Чхонан")
                        Text("Чхонджу").tag("Чхонджу")
                    }
                    .foregroundColor(Color("textColor"))
                    Group {
                        Text("Пхёнтхэк").tag("Пхёнтхэк")
                        Text("Сосан").tag("Сосан")
                        Text("Дунпо").tag("Дунпо")
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
            }
            Section {
                HStack {
                    Spacer()
                    Button("Создать") {
                        self.images = String(photos.count)
                        AdvManager().postAdv(adv: Adv(id: uid + Util().dateForAdv(date: Util().dateByTimeZone()), uid: uid + Util().dateForAdv(date: Util().dateByTimeZone()), name: name, category: category, city: city, price: price, phone: phone, description: description, createdAt: Util().dateByTimeZone(), images: images, updatedAt: Util().dateByTimeZone(), isActive: "1", subcategory: subcategory, visa: visa, gender: gender, shift: shift, age: age)) {}
//                        DB().createAdv(uid: uid, name: name, category: category, city: city, price: price, phone: phone, descrition: description, createdAt: Util().dateByTimeZone(), images: images, updatedAt: Util().dateByTimeZone(), isActive: "1", subcategory: subcategory) {
                            postImages() {
                                deleteImages() {
//                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
//                                        DB().getAdvs(category: "all") { (list) in
//                                            globalAdv = list
//                                                .filter { $0.isActive == "1" }
//                                                .sorted { $0.createdAt > $1.createdAt }
//                                        }
                                        showingAlert = true
//                                    }
//                                }
                            }
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
        }
        .onAppear {
        }
    }
    
    func postImages(completion: @escaping () -> Void) {
        var n = 0
        for photo1 in photos {
            DB().postImage(image: photo1, directory: directory, uid: uid + "ADV" + String(n), quality: 0.5)
            n += 1
            print("adding photo")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            completion()
        }
    }
    
    func deleteImages(completion: @escaping () -> Void) {
        for i in photos.count...4 {
            print(i)
            print("deleting")
            DB().deleteImage(uid: uid + "ADV" + String(i), directory: directory)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            completion()
        }
    }
}





