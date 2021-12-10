//
//  ServiceView.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/12/09.
//

import SwiftUI

struct ServiceView: View {
    var service: Service!
    
    var body: some View {
//        AsyncImage(url: URL(string: service.image[0])) { image in
//                image
//                    .resizable()
//                    .scaledToFill()
//            } placeholder: {
//                Image(systemName: "person")
//            }
//            .frame(width: 200, height: 200)
        Form {
            Section {
                RemoteImage(url: service.image[0])
                    .aspectRatio(contentMode: .fit)
                                .frame(width: 300)
                Text(service.name)
                    .font(.title2)
                
                HStack {
                    Text("Город")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Divider()
                    Text(service.city)
                        .font(.caption)
                }
                Text(service.address)
                    .font(.caption)
                    .foregroundColor(.gray)
                    
            
                Text(service.description)
                    .font(.caption)
            }
            
            Section {
                Button(action: {
                    call(numberString: service.phone)
                }) {
                    HStack(alignment: .center) {
                        Spacer()
                        Image(systemName: "phone.fill")
                        Text(service.phone)
                        Spacer()
                    }
                }
            }
        }
    }
    
    
    
    func call(numberString: String) {
        let telephone = "tel://"
        let formattedString = telephone + numberString
        guard let url = URL(string: formattedString) else { return }
        UIApplication.shared.open(url)
    }
}

//struct ServiceView_Previews: PreviewProvider {
//    static var previews: some View {
//        ServiceView(service: example_service)
//    }
//}


//#if DEBUG
//let example_service = Service(_id: "HNyHZZjtq298izgub", owner: "hPQwM9F7L9CxTZdRm", name: "Кафе RELAX", category: "food", city: "Ансан", address: "경기 안산시 단원구 원곡동 962, 지하 1층", phone: "010-2428-4522", image: ["relax", "relax"], description: "Европейская и азиатская кухня. Шашлыки, самса, тандырные лепешки Европейская и азиатская кухня. Шашлыки, самса, тандырные лепешки Европейская и азиатская кухня. Шашлыки, самса, тандырные лепешки Европейская и азиатская кухня. Шашлыки, самса, тандырные лепешки")
//#endif
