//
//  DetailsView.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/12/14.
//

import SwiftUI

struct DetailsView: View {
    var service: Service!
    @State private var image = UIImage(named: "blank")!
    
    var body: some View {
        ExpandedServiceDetails(service: service, image: image, count: service.images)
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView()
    }
}

