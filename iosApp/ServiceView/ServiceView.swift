//
//  ServiceView.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/12/09.
//

import SwiftUI
import MobileCoreServices

struct ServiceView: View {
    var service: Service!
    @State private var image = UIImage(named: "blank")!
    
    var body: some View {
        ExpandedServiceDetails(service: service, image: image)
    }
}
