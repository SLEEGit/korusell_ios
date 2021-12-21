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
    @State var business: Service!
    @State private var isShowPhotoLibrary = false
    @State private var image = UIImage(named: "avatar")!
    @State private var uid = Auth.auth().currentUser?.uid ?? ""
    
    @State var bname: String = ""
    @State var bphone: String = ""
    @State var city: String = ""
    @State var address: String = ""
    @State var description: String = ""
    @State var latitude: String = ""
    @State var longitude: String = ""
    @State var category: String = ""
    
//    @Binding var selectedImage: UIImage
//    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Image(uiImage: self.image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .cornerRadius(75)
                        .listRowSeparator(.hidden)
                        .onTapGesture {
                            print("Boo")

                            isShowPhotoLibrary = true
     
                        }                           .sheet(isPresented: $isShowPhotoLibrary) {
                            ImagePicker(selectedImage: self.$image, currentUid: self.$uid, sourceType: .photoLibrary)
                        }
                    Text(user.email ?? "")
                        .font(.title3)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .listRowInsets(EdgeInsets())
                .background(Color(UIColor.systemGroupedBackground))
//                NavigationLink(destination: EditNameView(name: $name, phone: $phone)) {
                    NavigationLink(destination: getDestination(name: name, phone: phone)) {
                    HStack {
                        Text("Имя")
                        Spacer()
                        Text(name)
                    }
                }
                NavigationLink(destination: getDestination(name: name, phone: phone)) {
                    HStack {
                        Text("Номер телефона")
                        Spacer()
                        Text(phone)
                    }
                }
                Section {
                    NavigationLink(destination: MyBusinessView(uid: $uid, name: $bname, city: $city, address: $address, phone: $bphone, description: $description, latitude: $latitude, longitude: $longitude, category: $category)) {
                        HStack {
                            Text("Мой Бизнес")
                            Spacer()
                            Text(bname)
                        }
                        
                    }
                    NavigationLink(destination: Text("Скоро мы добавим сюда объявления! 😇")) {
                        Text("Мои Объявления")
                    }
                }
                Section {
                    Button(action: {
                        showingAlert = true
//                        DB().getMyBusiness(uid: user.uid) { _ in
                            
//                        }
                    })
                    {
                        HStack {
                            Spacer()
                            Text("Выйти")
                                .foregroundColor(Color.red)
                            Spacer()
                        }
                    }
                    .alert("Вы действительно хотите выйти?", isPresented: $showingAlert) {
                        Button("Отмена", role: .cancel) {}
                        Button("Выйти") {
                            Authentication().signOut() {
                                logging.isSignedIn = false
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Моя страница")
        }.onAppear {
            DB().getUser(uid: user.uid) { user in
                name = user.name ?? ""
                phone = user.phone ?? ""
            }
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
            }
            DB().getAvatar(uid: uid) { image in
                self.image = image
            }
//            DB().fetchData2(category: "") { service in
////                self.business = service
//            }
        }
    }
    
    
    func getDestination(name: String, phone: String) -> AnyView {
            if Pref.userDefault.bool(forKey: "usersignedin") {
                return AnyView(EditNameView(name: $name, phone: $phone))
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
