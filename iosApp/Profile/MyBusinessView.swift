//
//  MyBusinessView.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/12/18.
//

import SwiftUI
import CachedAsyncImage

struct MyBusinessView: View {
    //    @State var service: Service!
    @Binding var uid: String
    @Binding var name: String
    @Binding var city: String
    @Binding var address: String
    @Binding var phone: String
    @Binding var description: String
    @Binding var latitude: String
    @Binding var longitude: String
    @Binding var category: String
    
    @State var directory: String = "images"
    @State private var image = UIImage(named: "blank")!
    @State private var isShowPhotoLibrary = false
    @State private var showingAlert = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    
    var body: some View {
        List {
            VStack {
                Image(uiImage: self.image)
                    .resizable()
                    .scaledToFill()
                    .listRowSeparator(.hidden)
                Button("Изменить фото") {
                    isShowPhotoLibrary = true
                }
                .sheet(isPresented: $isShowPhotoLibrary) {
                    ImagePicker(selectedImage: self.$image, currentUid: self.$uid, directory: $directory, sourceType: .photoLibrary)
                }
                
            }.padding()
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
                    Text("Финансовые услуги").tag("money")
                    Text("Красота/Здоровье").tag("health")
                    Text("СТО/Тюнинг").tag("car")
                    Text("Няни/Детсад").tag("nanny")
                }
                .foregroundColor(Color.black)
                Group {
                    Text("Образование").tag("study")
                    Text("Туризм").tag("tourism")
                }.foregroundColor(Color.black)
            }.foregroundColor(.gray)
            Picker("Город", selection: $city) {
                Group {
                    Text("Ансан").tag("Ансан")
                    Text("Хвасонг").tag("Хвасонг")
                    Text("Сеул").tag("Сеул")
                    Text("Инчхон").tag("Инчхон")
                    Text("Асан").tag("Асан")
                    Text("Чхонан").tag("Чхонан")
                }
                .foregroundColor(Color.black)
            }.foregroundColor(.gray)
            HStack {
                Text("Другой город")
                    .foregroundColor(.gray)
                TextField("Город", text: $city)
                    .disableAutocorrection(true)
            }
            HStack {
                Text("Адрес")
                    .foregroundColor(.gray)
                TextField("경기도 안산시 단원구 선이로 6", text: $address)
                    .disableAutocorrection(true)
            }
            HStack {
                Text("Номер телефона")
                    .foregroundColor(.gray)
                TextField("010-0000-0000", text: $phone)
                    .keyboardType(.phonePad)
            }
            VStack {
                Text("Описание")
                    .foregroundColor(.gray)
                TextEditor(text: $description)
                    .disableAutocorrection(true)
            }
            
            Section {
                HStack {
                    Spacer()
                    Button("Обновить данные") {
                        Util().getCoordinates(address: address) { coor in
                            if let coor = coor {
                                latitude = coor.latitude.description
                                longitude = coor.longitude.description
                            } else {
                                return
                            }
                            DB().updateBusiness(uid: uid, name: name, category: category, city: city, address: address, phone: phone, descrition: description, latitude: latitude, longitude: longitude) {
                                showingAlert = true
                            }
                        }
                        
                    }.alert("Данные успешно обновлены", isPresented: $showingAlert) {
                        Button("Ок") {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                    Spacer()
                }
            }
            
        }.onAppear {
            
            DB().getImage(uid: uid, directory: "images") { image in
                self.image = image
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

