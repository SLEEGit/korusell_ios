//
//  AddBusiness.swift
//  iosApp
//
//  Created by Sergey Lee on 2022/01/10.
//

import SwiftUI

struct AddBusinessView: View {
    //    @State var service: Service!
    @State var uid: String = ""
    @State var name: String = ""
    @State var city: String = ""
    @State var address: String = ""
    @State var phone: String = ""
    @State var description: String = ""
    @State var latitude: String = ""
    @State var longitude: String = ""
    @State var category: String = ""
    @State var social: [String] = ["","","","",""]
    
    @State var directory: String = "images"
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
                        PhotoPicker(photos: $photos, showPicker: self.$isShowPhotoLibrary, directory: "images", uid: uid)
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
                    Text("Рестораны/Кафе").tag("food")
                    Text("Магазины").tag("shop")
                    Text("Связь").tag("connect")
                    Text("Документы/Переводы").tag("docs")
                    Text("Транспорт/Переезд").tag("transport")
                    Text("Юридические услуги").tag("law")
                    Text("Мероприятия/Фото/Видео").tag("party")
                    Text("Красота/Здоровье").tag("health")
                    Text("СТО/Тюнинг").tag("car")
                    Text("Няни/Детсад").tag("nanny")
                }
                .foregroundColor(Color("textColor"))
                Group {
                    Text("Образование").tag("study")
                    Text("Туризм").tag("tourism")
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
                Text("Адрес")
                    .foregroundColor(.gray)
                TextField("Подсказка ->", text: $address)
                    .disableAutocorrection(true)
                Spacer()
                Image(systemName: "info.circle.fill")
                    .renderingMode(.original)
                    .shadow(radius: 2)
                    .onTapGesture {
                        showingHint = true
                    }.alert(isPresented: $showingHint) {
                        Alert(
                            title: Text("🤔 Чтобы Ваш бизнес отображался на карте, введите адрес на корейском языке без указания номера квартиры и этажа"),
                            dismissButton: .default(Text("Ок"))
                        )
                    }
                
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
            Group {
                Section {
                    NavigationLink(destination: AddLinksView(social: $social), label: {
                        Text("Добавить ссылки")
                    })
                }
                
                Section {
                    HStack {
                        Spacer()
                        Button("Обновить данные") {
                            self.images = String(photos.count)
                            Util().getCoordinates(address: address) { lat, long in
                                self.latitude = lat
                                self.longitude = long
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    DB().updateBusiness(uid: uid, name: name, category: category, city: city, address: address, phone: phone, descrition: description, latitude: latitude, longitude: longitude, social: social, images: images) {
                                        var n = 0
                                        for photo1 in photos {
                                            DB().postImage(image: photo1, directory: directory, uid: uid+String(n), quality: 0.1)
                                            n += 1
                                        }
                                        for i in photos.count...4 {
                                            print(i)
                                            print("iii")
                                            DB().deleteImage(uid: uid + String(i), directory: directory)
                                        }
                                        showingAlert = true
                                    }
                                }
                            }
                            
                            
                        }.alert(isPresented: $showingAlert) {
                            Alert(
                                title: Text("Данные успешно обновлены"),
                                dismissButton: .destructive((Text("Ок")), action: {
                                    presentationMode.wrappedValue.dismiss()
                                })
                            )
                        }
                        Spacer()
                    }
                }
                
                
                Section {
                    HStack {
                        Spacer()
                        Button(action: {
                            showingAlertDelete = true
                        }) {
                            Text("Удалить бизнес")
                                .foregroundColor(Color.red)
                        }.disabled(
                            self.name == "" &&
                            self.category == "" &&
                            self.city == "" &&
                            self.address == "" &&
                            self.phone == "" &&
                            self.description == ""
                        ).alert(isPresented: $showingAlertDelete) {
                            Alert(
                                title: Text("Вы уверены что хотите удалить Ваш бизнес?"),
                                primaryButton: .destructive(Text("Удалить"), action: {
                                    DB().deleteBusiness(uid: uid)
                                    for i in 0...4 {
                                        print(i)
                                        print("iii")
                                        DB().deleteImage(uid: uid + String(i), directory: directory)
                                    }
                                    self.name = ""
                                    self.category = ""
                                    self.city = ""
                                    self.address = ""
                                    self.phone = ""
                                    self.description = ""
                                    presentationMode.wrappedValue.dismiss()
                                    
                                }),
                                secondaryButton: .cancel(Text("Отмена"))
                            )
                        }
                        Spacer()
                    }
                }
                
            }
        }.alert(isPresented: $businessWarning) {
            Alert(
                title: Text("Создавая бизнес страницу, информация из Вашего профиля становится также доступной"),
                dismissButton: .default(Text("Ок"))
            )
        }
        
        .navigationTitle("Мой Бизнес")
        .onAppear {
            businessWarning = true
            if Pref.userDefault.bool(forKey: "business") {
                businessWarning = false
            }
            Pref.userDefault.set(true, forKey: "business")
            Pref.userDefault.synchronize()
            DB().getMultiImages(uid: uid, directory: directory) { images in
                self.photos = images
            }
        }
    }
}

//struct MyBusinessView_Previews: PreviewProvider {
//    static var previews: some View {
//        MyBusinessView()
//    }
//}

//#if DEBUG
//let example_service = Service(_id: "HNyHZZjtq298izgub", owner: "hPQwM9F7L9CxTZdRm", name: "Кафе RELAX", category: "food", city: "Ансан", address: "경기 안산시 단원구 원곡동 962, 지하 1층", phone: "010-2428-4522", image: ["relax", "relax"], description: "Европейская и азиатская кухня. Шашлыки, самса, тандырные лепешки Европейская и азиатская кухня. Шашлыки, самса, тандырные лепешки Европейская и азиатская кухня. Шашлыки, самса, тандырные лепешки Европейская и азиатская кухня. Шашлыки, самса, тандырные лепешки")
//#endif

