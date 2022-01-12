//
//  MyAdvListView.swift
//  iosApp
//
//  Created by Sergey Lee on 2022/01/04.
//

import SwiftUI
import FirebaseAuth

struct MyAdvListView: View {
    
    @State var list: [Adv] = []
    @State private var image = UIImage(named: "blank")!
    @State private var uid = Auth.auth().currentUser?.uid ?? ""
    
//    @State var adv: Adv!
//    @State var aname: String = ""
//    @State var aphone: String = ""
//    @State var acity: String = ""
//    @State var aaddress: String = ""
//    @State var adescription: String = ""
//    @State var price: String = ""
//    @State var createdAt: String = ""
//    @State var acategory: String = ""
    
    var body: some View {
        List(list) { item in
//            NavigationLink(destination: AdvDetailsView(adv: item)) {
            NavigationLink(destination: MyAdvView(adv: item) {
                ExpandedAdv(adv: item, image: image)
            }
        }
        .onAppear {
            DB().getAdvs(category: "all") { (list) in
                globalAdv = list
                self.list = globalAdv.filter { $0.uid.contains(uid)  }
            }
        }
    }
}

struct MyAdvListView_Previews: PreviewProvider {
    static var previews: some View {
        MyAdvListView()
    }
}
