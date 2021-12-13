//
//  MapView.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/12/13.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @State private var city: String = "Все города"
    
    var body: some View {
        Text(city)
            .onAppear {
                city = globalCity
            }
    }
    
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
