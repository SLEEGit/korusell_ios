//
//  ServiceView.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/12/09.
//

import SwiftUI
import CachedAsyncImage
import MobileCoreServices

struct ServiceView: View {
    var service: Service!
    @State private var image = UIImage(named: "blank")!
    
    var body: some View {
        ExpandedServiceDetails(service: service, image: image)
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
