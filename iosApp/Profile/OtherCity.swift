//
//  OtherCity.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/12/25.
//

import SwiftUI

struct OtherCity: View {
    @Binding var city: String
    
    var body: some View {
        HStack {
            Text("Ввести вручную")
                .foregroundColor(.gray)
            TextField("Подсказка ->", text: $city)
                .disableAutocorrection(true)
            
        }
    }
}

//struct OtherCity_Previews: PreviewProvider {
//    static var previews: some View {
//        OtherCity()
//    }
//}
