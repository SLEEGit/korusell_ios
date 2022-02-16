//
//  MyAdvList.swift
//  iosApp
//
//  Created by Sergey Lee on 2022/01/14.
//

import SwiftUI
import FirebaseAuth

struct MyAdvList: View {
    @StateObject var advManager = AdvManager()
    @State var isLoading: Bool = true
    @State var showingAlertDelete: Bool = false
    
    @State var openAddAdv: Bool = false
    @State var openAddWork: Bool = false
    
    
    @State var myUID: String
    @State var newUid: String = ""
    @State var uid: String = ""
    @State var name: String = ""
    @State var phone: String = ""
    @State var city: String = ""
    @State var address: String = ""
    @State var description: String = ""
    @State var price: String = ""
    @State var createdAt: String = ""
    @State var category: String = ""
    @State var updatedAt: String = ""
    @State var isActive: String = ""
    @State var subcategory: String = "subcategory"
    @State var visa: [String] = []
    @State var gender: String = "gender"
    @State var shift: String = "shift"
    @State var age: [String] = []
    
    @State private var photos: [UIImage] = []
    
    @Binding var count: Int
    
    var body: some View {
        ZStack {
            NavigationLink(destination: NewAdvView(uid: $myUID, name: $name, city: $city, price: $price, phone: $phone, description: $description, category: $category, updatedAt: $updatedAt, isActive: $isActive, subcategory: $subcategory, visa: $visa, gender: $gender, shift: $shift, age: $age, photos: $photos), isActive: $openAddAdv) {}
            NavigationLink(destination: NewWorkView(uid: $myUID, name: $name, city: $city, price: $price, phone: $phone, description: $description, category: $category, updatedAt: $updatedAt, isActive: $isActive, subcategory: $subcategory, visa: $visa, gender: $gender, shift: $shift, age: $age, photos: $photos), isActive: $openAddWork) {}
            List {
                Section {
                    if count != 0 {
                        Text("Нажмите и удерживайте объявление, чтобы удалить")
                    } else {
                        Text("Нажмите 'Добавить', чтобы добавить объявление")
                    }
                }
                .padding()
                .foregroundColor(Color("graytext"))
                .font(.system(size: 15))
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .listRowInsets(EdgeInsets())
                .background(Color(UIColor.systemGroupedBackground).opacity(0.1))
                .background(Color(UIColor.systemGroupedBackground))
                
                ForEach(advManager.myAdvs, id: \.uid) { adv in
                    NavigationLink(destination: getNavigation(adv: adv)) {
                        getDestination(adv: adv)
                            .opacity(Double(adv.isActive)!)
                            .contextMenu {
                                Button(action: {
                                    showingAlertDelete = true
                                }) {
                                    HStack {
                                        Image(systemName: "trash")
                                        Text("Удалить")
                                    }
                                }
                                
                            }
                            .alert(isPresented: $showingAlertDelete) {
                                Alert(
                                    title: Text("Вы уверены что хотите удалить Ваше объявление?"),
                                    primaryButton: .destructive(Text("Удалить"), action: {
                                        advManager.deleteAdv(uid: adv.uid) {}
                                    }),
                                    secondaryButton: .cancel(Text("Отмена"))
                                )
                            }
                    }
                }
            }
            .navigationTitle("Мои Объявления")
            .onAppear {
                advManager.getMyAdvs() {
                    count = advManager.myAdvs.count
                    self.isLoading = false
                }
            }
            .disabled(isLoading)
            if isLoading {
                ProgressView().progressViewStyle(CircularProgressViewStyle(tint: Color("textColor")))
                    .background(Color(UIColor.systemGroupedBackground).opacity(0.1))
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Menu {
                    Button("Добавить Объявление") {
                        openAddAdv.toggle()
                    }
                    Button("Добавить Вакансию") {
                        openAddWork.toggle()
                    }
                } label: {
                    HStack {
                        Text("Добавить")
                            .font(.system(size: 15))
                    }
                }
            }
        }
    }
    
}

func getDestination(adv: Adv) -> AnyView {
    if adv.category == "work" {
        return AnyView(OneWorkView(adv: adv))
    } else {
        return AnyView(MyAdvView(adv: adv))
    }
}

func getNavigation(adv: Adv) -> AnyView {
    if adv.category == "work" {
        return AnyView(InnerWork(adv:adv))
    } else {
        return AnyView(InnerAdvertisement(adv: adv))
    }
}

struct MyAdvView: View {
    let adv: Adv
    @State var imagename: String = "launchicon_mini"
    @State var image: UIImage = UIImage(named: "launchicon_mini")!
    
    var body: some View {
        HStack(alignment: .top) {
            //            UrlImageView(urlString: post.uid  + "ADV" + "0", directory: "advImages")
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
            VStack(alignment: .leading) {
                Text(Util().formatDate(date: adv.updatedAt))
                    .padding(.leading, 4).padding(.trailing, 4).padding(.bottom, 3).padding(.top, 2)
                    .font(.caption)
                    .foregroundColor(Color.gray)
                Text(adv.name)
                    .lineLimit(2)
                    .font(.headline)
                    .padding(.leading, 4).padding(.trailing, 4).padding(.bottom, 2)
                Text(adv.city)
                    .foregroundColor(Color.gray)
                    .lineLimit(5)
                    .font(.caption)
                    .padding(.leading, 4).padding(.trailing, 4).padding(.bottom, 2)
                Text(adv.price)
                    .font(.title3)
            }.frame(height: 150, alignment: .leading)
                .onAppear {
                    DB().getImage(uid: adv.uid + "ADV" + "0", directory: "advImages") { image in
                        self.image = image
                    }
                }
        }
    }
}

