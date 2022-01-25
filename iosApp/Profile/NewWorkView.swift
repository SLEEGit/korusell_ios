//
//  NewWorkView.swift
//  iosApp
//
//  Created by Sergey Lee on 2022/01/25.
//

import SwiftUI

struct NewWorkView: View {
    @Binding var uid: String
    @Binding var name: String
    @Binding var city: String
    @Binding var price: String
    @Binding var phone: String
    @Binding var description: String
    @Binding var category: String
    @Binding var updatedAt: String
    @Binding var isActive: String
    @Binding var subcategory: String
    
    
    @State var directory: String = "advImages"
    @State private var image = UIImage(named: "blank")!
    @State private var isShowPhotoLibrary = false
    @State private var showingAlert = false
    @State private var showingAlertDelete = false
    @State private var showingHint = false
    @State private var showingHint2 = false
    @State private var businessWarning = false
    @Binding var photos: [UIImage]
    @State var images: String = "0"
    @State var checked: Bool = false
    
    @State private var language = false
    @State private var sex: String = "male"
    @State private var f1 = false
    @State private var h2 = false
    @State private var f4 = false
    @State private var other = false
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    
    var body: some View {
        Form {
            Group {
                HStack {
                    Text("Заголовок")
                        .foregroundColor(.gray)
                    TextField("Название", text: $name)
                        .disableAutocorrection(true)
                }
                Picker("🛠 Виды работ", selection: $subcategory) {
                    Group {
                        Text("🏭 Завод").tag("factory")
                        Text("👷🏻‍♀️ Стройка").tag("construction")
                        Text("🏩 Мотель").tag("motel")
                        Text("🍽 Общепит").tag("cafe")
                        Text("🧑🏽‍🌾 Сельхоз работы").tag("farm")
                        Text("📦 Почта/Доставка").tag("delivery")
                        Text("💼 Работа в офисе").tag("office")
                        Text("👨‍🚀 Другая работа").tag("otherwork")
                    }.foregroundColor(Color("textColor"))
                }
                .foregroundColor(.gray)
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
                    Text("💰 Зарплата")
                        .foregroundColor(.gray)
                    TextField("", text: $price)
                        .disableAutocorrection(true)
                }
                HStack {
                    Text("☎️ Номер телефона")
                        .foregroundColor(.gray)
                    TextField("010-0000-0000", text: $phone)
                }
                HStack {
                    Text("🇰🇷 Корейский язык")
                        .foregroundColor(.gray)
                    Toggle("", isOn: $language)
                }
                Picker("Пол", selection: $sex) {
                    Group {
                        Text("👱🏼‍♂️ Мужчина").tag("male")
                        Text("👩🏻 Женщина").tag("female")
                    }.foregroundColor(Color("textColor"))
                }.pickerStyle(SegmentedPickerStyle())
                    .foregroundColor(.gray)
                HStack {
                    Toggle("H2", isOn: $h2)
                        .toggleStyle(CheckboxToggleStyle(style: .circle))
                    Toggle("H4", isOn: $f4)
                        .toggleStyle(CheckboxToggleStyle(style: .circle))
                    Toggle("F1", isOn: $f1)
                        .toggleStyle(CheckboxToggleStyle(style: .circle))
                    Toggle("Другая", isOn: $other)
                        .toggleStyle(CheckboxToggleStyle(style: .circle))
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
                        AdvManager().postAdv(adv: Adv(id: uid + Util().dateForAdv(date: Util().dateByTimeZone()), uid: uid + Util().dateForAdv(date: Util().dateByTimeZone()), name: name, category: "work", city: city, price: price, phone: phone, description: description, createdAt: Util().dateByTimeZone(), images: images, updatedAt: Util().dateByTimeZone(), isActive: "1", subcategory: subcategory)) {}
                        showingAlert = true
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
}





