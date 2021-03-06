//
//  Profile.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/12/05.
//

import SwiftUI
import FirebaseAuth
import FirebaseStorage

struct ProfileView: View {
    
    @ObservedObject var logging: Logging
    @State var user: FirebaseAuth.User = Auth.auth().currentUser!
    @State private var showingAlert = false
    @State var name: String = ""
    @State var phone: String = ""
    @State var avatar: String = ""
    @State var email: String = ""
    
    @State private var isShowPhotoLibrary = false
    @State private var isShowInfo = false
    @State private var image = UIImage(named: "avatar")!
    @State private var uid = Auth.auth().currentUser?.uid ?? ""
    @State var directory: String = "avatars"
    
    @State var business: Service!
    @State var bname: String = ""
    @State var bphone: String = ""
    @State var city: String = ""
    @State var address: String = ""
    @State var description: String = ""
    @State var latitude: String = ""
    @State var longitude: String = ""
    @State var category: String = ""
    @State var social: [String] = ["","","","",""]
    

    @StateObject var advManager = AdvManager()
    @StateObject var serviceManager = ServiceManager()
    @StateObject var firestore = FireStore()
    @State var list: [Adv] = []
    @State var count: Int = 0
    
    //    @Environment(\.presentationMode) var presentationMode
    //    @Binding var selectedImage: UIImage
    //    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    if #available(iOS 15.0, *) {
                        VStack {
                            Image(uiImage: self.image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .cornerRadius(75)
                            Button("Изменить фото профиля") {
                                isShowPhotoLibrary = true
                            }                           .sheet(isPresented: $isShowPhotoLibrary) {
                                ImagePicker(selectedImage: self.$image, currentUid: self.$uid, directory: $directory, sourceType: .photoLibrary)
                            }
                        }
                        .listRowSeparator(.hidden)
                    } else {
                        VStack {
                            Image(uiImage: self.image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .cornerRadius(75)
                            Button("Изменить фото профиля") {
                                isShowPhotoLibrary = true
                            }                           .sheet(isPresented: $isShowPhotoLibrary) {
                                ImagePicker(selectedImage: self.$image, currentUid: self.$uid, directory: $directory, sourceType: .photoLibrary)
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
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
                HStack {
                    Text("Номер телефона")
                    Spacer()
                    Text(phone)
                }
                Section {
                    NavigationLink(destination: MyBusinessView(id: $uid, uid: $uid, name: $bname, city: $city, address: $address, phone: $bphone, description: $description, latitude: $latitude, longitude: $longitude, category: $category, social: $social)) {
                        HStack {
                            Text("💼")
                            Text("Мой Бизнес")
                            Spacer()
                            Text(bname)
                        }
                        
                    }
                    NavigationLink(destination: MyAdvList(myUID: uid, count: $count)) {
                        HStack {
                            Text("🏷")
                            Text("Мои Объявления")
                            Spacer()
                            if count != 0 {
                                Text(String(count))
                            }
                        }
                    }
                }
                Section {
                    NavigationLink(destination: getDestination(name: name, phone: phone)) {
                        HStack {
                            Text("👨🏻‍💻")
                            Text("Управление аккаунтом")
                        }
                        
                    }
                }
                Section {
                    NavigationLink(destination: Contacts()) {
                        HStack {
                            Text("✉️")
                            Text("Написать разработчикам")
                        }
                    }
                }
                Section {
                    Button(action: {
                        showingAlert = true
                    })
                    {
                        HStack {
                            Spacer()
                            Text("Выйти")
                                .foregroundColor(Color.red)
                            Spacer()
                        }
                    }
                    .alert(isPresented: $showingAlert) {
                        Alert(
                            title: Text("Вы действительно хотите выйти?"),
                            primaryButton: .destructive(Text("Выйти"), action: {
                                Authentication().signOut() {
                                    logging.isSignedIn = false
                                }
                            }),
                            secondaryButton: .cancel(Text("Отмена"))
                        )
                    }
                }
            }
            .navigationBarTitle("Моя страница")
//            .toolbar {
//                Button(action: {
//                    isShowInfo = true
//                }) {
//                    Image(systemName: "questionmark.circle.fill")
//                        .renderingMode(.original)
//                        .shadow(radius: 2)
//                }.sheet(isPresented: $isShowInfo) {
//                    Info()
//                }
//
//            }
            
        }
        .onAppear {
            firestore.getUser(uid: user.uid) { user in
                name = user.name ?? ""
                phone = user.phone ?? ""
                email = user.email
            }

            firestore.updateLastLogin(user: user, last_login: Util().dateByTimeZone()) {}

            advManager.getMyAdvs() {
                self.count = advManager.myAdvs.count
            }
            
            serviceManager.getMyService(uid: self.uid) { business in
                self.business = business
                self.bname = business.name
                self.bphone = business.phone
                self.city = business.city
                self.address = business.address
                self.description = business.description
                self.latitude = business.latitude
                self.longitude = business.longitude
                self.category = business.category
                self.social = business.social
            }
            
            DB().getImage(uid: uid, directory: "avatars") { image in
                self.image = image
            }
        }
    }
    
    
    func getDestination(name: String, phone: String) -> AnyView {
        if Pref.userDefault.bool(forKey: "usersignedin") {
            return AnyView(EditNameView(name: $name, phone: $phone, logging: logging))
        } else {
            return AnyView(Text("Logged out"))
        }
    }
    
}
