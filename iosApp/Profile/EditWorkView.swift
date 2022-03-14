//
//  EditWorkView.swift
//  iosApp
//
//  Created by Sergey Lee on 2022/01/27.
//

import SwiftUI

struct EditWorkView: View {
    @Binding var id: UUID
    @Binding var uid: String
    @Binding var name: String
    @Binding var city: String
    @Binding var price: String
    @Binding var phone: String
    @Binding var description: String
    @Binding var category: String
    @Binding var updatedAt: String
    @Binding var createdAt: String
    @Binding var isActive: String
    @Binding var subcategory: String
    @Binding var visa: [String]
    @Binding var gender: String
    @Binding var shift: String
    @Binding var age: [String]
    
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
    
    @State private var f1 = false
    @State private var h2 = false
    @State private var f4 = false
    @State private var other = false
    @State private var gender1 = false
    @State private var gender2 = false
    @State private var shift1 = false
    @State private var shift2 = false
    @State private var anyAge = false
    @State private var anyVisa = false
    
    @State private var stepperValue1: Int = 20
    @State private var stepperValue2: Int = 50
    
    
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
                    VStack(alignment: .leading) {
                        Text("Пол:")
                            .padding(.bottom, 5) 
                            .foregroundColor(.gray)
                        HStack {
                            Toggle("👱🏼‍♂️", isOn: $gender1)
                                .toggleStyle(CheckboxToggleStyle(style: .circle))
                            Toggle("👩🏻", isOn: $gender2)
                                .toggleStyle(CheckboxToggleStyle(style: .circle))
                        }
                    }
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("Смена:")
                            .padding(.bottom, 5)
                            .foregroundColor(.gray)
                        HStack {
                            Toggle("🌞", isOn: $shift1)
                                .toggleStyle(CheckboxToggleStyle(style: .circle))
                            Toggle("🌚", isOn: $shift2)
                                .toggleStyle(CheckboxToggleStyle(style: .circle))
                        }
                    }
                }
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("Визы:")
                            .foregroundColor(.gray)
                            
                        Toggle("Любая", isOn: $anyVisa)
                            .toggleStyle(CheckboxToggleStyle(style: .circle))
                    }.padding(.bottom, 10)
                    
                    if !anyVisa {
                        HStack {
                            Toggle("H2", isOn: $h2)
                                .toggleStyle(CheckboxToggleStyle(style: .circle))
                            Toggle("F4", isOn: $f4)
                                .toggleStyle(CheckboxToggleStyle(style: .circle))
                            Toggle("F1", isOn: $f1)
                                .toggleStyle(CheckboxToggleStyle(style: .circle))
                            Toggle("Другие", isOn: $other)
                                .toggleStyle(CheckboxToggleStyle(style: .circle))
                        }
                    }
                    
                }
                VStack(alignment: .leading) {
                    HStack {
                        Text("Возраст: ")
                            .foregroundColor(.gray)
                        Toggle("Любой", isOn: $anyAge)
                            .toggleStyle(CheckboxToggleStyle(style: .circle))
                    }
                    if !anyAge {
                        VStack {
                            Stepper("От: \(stepperValue1)", value: $stepperValue1, in: 20...65, step: 5)
                            Stepper("До: \(stepperValue2)", value: $stepperValue2, in: 25...70, step: 5)
                        }
                    }
                }
                
                VStack(alignment: .leading) {
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
                    Button("Обновить") {
                        visa.removeAll()
                        self.images = String(photos.count)
                        if f1 {
                            visa.append("F1")
                        }
                        if f4 {
                            visa.append("F4")
                        }
                        if h2 {
                            visa.append("H2")
                        }
                        if other {
                            visa.append("Другая")
                        }
                        if f1 && f4 && h2 && other || anyVisa {
                            visa.removeAll()
                            visa.append("Любая")
                        }
                        if gender1 && !gender2 {
                            gender = "👱🏼‍♂️"
                        } else if !gender1 && gender2 {
                            gender = "👩🏻"
                        } else if gender1 && gender2 {
                            gender = "👱🏼‍♂️👩🏻"
                        } else {
                            gender = ""
                        }
                        
                        if shift1 && !shift2 {
                            shift = "🌞"
                        } else if !shift1 && shift2 {
                            shift = "🌚"
                        } else if shift1 && shift2 {
                            shift = "🌞🌚"
                        } else {
                            shift = ""
                        }
                        age.removeAll()
                        if anyAge {
                            age.append("20")
                            age.append("70")
                        } else {
                            age.append(String(stepperValue1))
                            age.append(String(stepperValue2))
                        }
                        
                        AdvManager().postAdv(adv: Adv(id: id.description, uid: uid, name: name, category: "work", city: city, price: price, phone: phone, description: description, createdAt: createdAt, images: images, updatedAt: Util().dateByTimeZone(), isActive: "1", subcategory: subcategory, visa: visa, gender: gender, shift: shift, age: age)) {
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//                                showingAlert = true
//                            }
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
            if visa.contains("F1") {
                self.f1 = true
            }
            if visa.contains("F4") {
                self.f4 = true
            }
            if visa.contains("H2") {
                self.h2 = true
            }
            if visa.contains("Другая") {
                self.other = true
            }
            if visa.contains("Любая") {
                self.f1 = true
                self.f4 = true
                self.h2 = true
                self.other = true
                self.anyVisa = true
            }
            if self.gender.contains("👱🏼‍♂️") {
                self.gender1 = true
            }
            if self.gender.contains("👩🏻") {
                self.gender2 = true
            }

            if self.shift.contains("🌞") {
                self.shift1 = true
            }
            if self.shift.contains("🌚") {
                self.shift2 = true
            }
            if age[0] == "20" && age[1] == "70" {
                self.anyAge = true
            }
            self.stepperValue1 = Int(age[0]) ?? 20
            self.stepperValue2 = Int(age[1]) ?? 50
        }
    }
}


