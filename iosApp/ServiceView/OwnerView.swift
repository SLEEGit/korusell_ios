//
//  OwnerView.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/12/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseStorage

struct OwnerView: View {

    @State var name: String = ""
    @State var phone: String = ""
    @State var email: String = ""
    @State var avatar: String = ""

    @State private var image = UIImage(named: "avatar")!
    
    var ownerUid: String = ""
    
    var body: some View {
        Form {
            Section {
                if #available(iOS 15.0, *) {
                    VStack {
                        Image(uiImage: self.image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .cornerRadius(75)
                    }
                    .listRowSeparator(.hidden)
                } else {
                    VStack {
                        Image(uiImage: self.image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .cornerRadius(75)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .listRowInsets(EdgeInsets())
                        .background(Color(UIColor.systemGroupedBackground).opacity(0.1))
                        .background(Color(UIColor.systemGroupedBackground))
                }
                
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .listRowInsets(EdgeInsets())
            .background(Color(UIColor.systemGroupedBackground))
            //                NavigationLink(destination: EditNameView(name: $name, phone: $phone)) {
            
            HStack {
                Text("Эл. почта")
                Spacer()
                Text(email)
            }
            HStack {
                Text("Имя")
                Spacer()
                Text(name)
            }
            if phone != "" {
                Section {
                    Button(action: {
                        Util().call(numberString: phone)
                    }) {
                        HStack(alignment: .center) {
                            Spacer()
                            Image(systemName: "phone.fill")
                            Text(phone)
                            Spacer()
                        }
                    }
                    
                }
            }

            
        }
        .onAppear {
            DB().getUser(uid: ownerUid) { user in
                name = user.name ?? ""
                phone = user.phone ?? ""
                email = user.email
            }
            
            DB().getImage(uid: ownerUid, directory: "avatars") { image in
                self.image = image
            }
        }
    }
}
