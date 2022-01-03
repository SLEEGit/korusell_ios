//
//  AdvDetailsView.swift
//  iosApp
//
//  Created by Sergey Lee on 2022/01/03.
//

import SwiftUI
import MobileCoreServices

struct AdvDetailsView: View {
    var adv: Adv!
    @State private var image = UIImage(named: "blank")!
    
    var body: some View {
        ExpandedAdvDetails(adv: adv, image: image)
    }
}
