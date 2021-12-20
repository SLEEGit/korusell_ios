//
//  MyBusinessView.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/12/18.
//

import SwiftUI
import CachedAsyncImage

struct MyBusinessView: View {
    @State var service: Service!
    @Binding var businessName: String
    @Binding var name: String
    @Binding var city: String
    @Binding var address: String
    @Binding var phone: String
    @Binding var description: String
    @State private var showingAlert = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        List {
            HStack {
                Spacer()
                CachedAsyncImage(url: URL(string: service.image[0])) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    Image("logo")
                        .aspectRatio(contentMode: .fit)
                }
                Spacer()
            }
            TextField("Название", text: $name)
            TextField("Город", text: $city)
            TextField("Адрес", text: $address)
            TextField("Номер телефона", text: $phone)
            TextField("Описание", text: $description)
         
            Section {
                HStack {
                    Spacer()
                    Button("Обновить данные") {
                        DB().updateBusiness(uid: service.owner, _id: service._id, name: name, city: city, address: address, phone: phone, descrition: description, owner: service.owner, image: service.image, latitude: service.latitude, longitude: service.longitude) {
                            showingAlert = true
                            businessName = name
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

