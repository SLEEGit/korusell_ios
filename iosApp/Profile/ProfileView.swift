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
    
    @State var adv: Adv!
    @State var aname: String = ""
    @State var aphone: String = ""
    @State var acity: String = ""
    @State var aaddress: String = ""
    @State var adescription: String = ""
    @State var price: String = ""
    @State var createdAt: String = ""
    @State var acategory: String = ""
    
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
                    NavigationLink(destination: MyBusinessView(uid: $uid, name: $bname, city: $city, address: $address, phone: $bphone, description: $description, latitude: $latitude, longitude: $longitude, category: $category, social: $social)) {
                        HStack {
                            Text("💼")
                            Text("Мой Бизнес")
                            Spacer()
                            Text(bname)
                        }
                        
                    }
                    NavigationLink(destination: MyAdvView(uid: $uid, name: $aname, city: $acity, price: $price, phone: $aphone, description: $adescription, createdAt: $createdAt, category: $acategory)) {
                        HStack {
                            Text("🏷")
                            Text("Мои Объявления")
                            Spacer()
                            Text(aname)
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
                    Button(action: {
                        isShowInfo = true
                    }) {
                        HStack {
                            Spacer()
                            Image(systemName: "message.fill")
                            Text("Написать разработчикам")
                            Spacer()
                        }
                        
                    }.sheet(isPresented: $isShowInfo) {
                        Info()
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
            
        }.onAppear {
            DB().getUser(uid: user.uid) { user in
                name = user.name ?? ""
                phone = user.phone ?? ""
                email = user.email
            }
            DB().updateLastLogin(user: user, last_login: Util().dateByTimeZone()) {}
            DB().getMyBusiness(uid: user.uid) { business in
                print("getting business in profile")
                print(business)
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
            
            DB().getMyAdv(uid: user.uid) { adv in
                print("getting adv in profile")
                print(adv)
                self.adv = adv
                self.aname = adv.name
                self.aphone = adv.phone
                self.acity = adv.city
                self.price = adv.price
                self.adescription = adv.description
                self.createdAt = adv.createdAt
                self.acategory = adv.category
            }
            
            DB().getImage(uid: uid, directory: "avatars") { image in
                self.image = image
            }
            //            DB().fetchData2(category: "") { service in
            ////                self.business = service
            //            }
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
//struct Profile_Previews: PreviewProvider {
//    static var previews: some View {
//        Profile(person: example3, viewModel: viewModel)
//    }
//}

//#if DEBUG
////let example3 = Person(_id: "HNyHZZjtq298izgub", avatar: "", name: "sd", username: "username", email:"asdasda", phone: "010 1233 1111")
//let example3 = User(uid: "123", displayName: "dis name", email: "test@test.thisistest", avatar: "avatar", phone: "010-0000-0000")
//#endif


//struct ExtractedView: View {
//    var body: some View {
//        Form {
//            Section {
//                HStack {
//                    Text("Имя")
//                        .font(.caption)
//                    Spacer()
//                    TextField(namePlaceholder, text: $name)
//                        .font(.caption)
//                }
//                HStack {
//                    Text("Номер телефона")
//                        .font(.caption)
//                    Spacer()
//                    TextField(phonePlaceholder, text: $phone)
//                        .font(.caption)
//                }
//            }
//            Section {
//                Button(action: {
//                    showingAlert = true
//                })
//                {
//                    HStack {
//                        Spacer()
//                        Text("Выйти")
//                            .foregroundColor(Color.red)
//                        Spacer()
//                    }
//                }
//                .alert("Вы действительно хотите выйти?", isPresented: $showingAlert) {
//                    Button("Отмена", role: .cancel) {}
//                    Button("Выйти") {
//                        Authentication().signOut() {
//                            logging.isSignedIn = false
//                        }
//                    }
//                }
//            }
//        }
//    }
//}
//        .toolbar {
//            Button("Обновить данные") {
//                DB().addNamePhone(user: user, name: name, phone: phone) {
//                    showingAlert2 = true
//                }
//            }.alert("Данные успешно обновлены", isPresented: $showingAlert2) {
//                Button("Ок", role: .cancel) {}
//            }
//        }
//}.onAppear {
//    DB().getUser(uid: user.uid) { user in
//        name = user.name ?? ""
//        phone = user.phone ?? ""
//    }
//}
