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
        ExpandedServiceDetails(service: service, image: image, count: service.images)
    }
}

struct ExpandedServiceDetails: View {
    @State var service: Service
    @State var image: UIImage
    @State var isShowSheet: Bool = false
    @State var addressCopy: Bool = false
    @State var array: [Int] = [0]
    @State var arrayIm: [UIImage] = []
    @State var newArray: [Int] = []
    @State var count: String = ""
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                TabView {
                    ForEach(array, id: \.self) { photo in
                        UrlImageView(urlString: service.uid + String(photo), directory: "images")
                            .scaledToFit()
                            .cornerRadius(10)
                    }
                }
                .padding()
                .frame(height: 400)
                .cornerRadius(15)
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                .tabViewStyle(.page)
                Group {
                    Text(service.name)
                        .font(.title)
                        .bold()
                        .padding(.leading, 15).padding(.trailing, 15)
                    HStack {
                        Text("Город")
                            .font(.body)
                            .foregroundColor(.gray)
                        Text(service.city)
                            .font(.body)
                        
                    }.padding(.leading, 15)
                        .padding(.bottom, 10)
                        .padding(.top, 10)
                    if service.address != "" {
                        HStack {
                            Text("Адрес")
                                .font(.body)
                                .foregroundColor(.gray)
                            Text(service.address)
                                .font(.body)
                            
                            Button(action: {
                                UIPasteboard.general.string = service.address
                                addressCopy = true
                            }) {
                                Image(systemName: "doc.on.doc")
                            }.alert(isPresented: $addressCopy) {
                                Alert (
                                    title: Text("Адрес скопирован"),
                                    dismissButton: .default(Text("Ok"))
                                )
                            }
                            
                        }.padding(.leading, 15)
                            .padding(.trailing, 15)
                            .padding(.bottom, 15)
                    }
                    Divider()
                    Text("Описание")
                        .font(.headline)
                        .padding(15)
                    Text(service.description)
                        .font(.body)
                        .multilineTextAlignment(.leading)
                        .lineLimit(nil)
                        .padding(.horizontal, 15)
                        .padding(.bottom, 20)
                    // эта штука снизу убрала троеточие в тексте
                        .minimumScaleFactor(0.1)
                }
                Divider().padding(.bottom, 20)
                if service.phone != "" {
                    HStack {
                        Spacer()
                        Button(action: {
                            Util().call(numberString: service.phone)
                        }) {
                            Image(systemName: "phone.fill")
                            Text(service.phone)
                        }
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.accentColor)
                        .cornerRadius(15)
                        Spacer()
                    }
                    .padding(.vertical, 20)
                    
                }
                
                HStack(spacing: 30) {
                    Spacer()
                    if service.social[0] != "" && service.social[0] != "https://www.facebook.com/" {
                        Link(destination: URL(string: service.social[0]) ?? URL(string: "https://www.facebook.com/")!, label: {
                            Image("facebook")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                        })
                    }
                    if service.social[1] != "" && service.social[1] != "https://www.instagram.com/" {
                        Link(destination: URL(string: service.social[1]) ?? URL(string: "https://www.instagram.com/")!, label: {
                            Image("instagram")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                        })
                    }
                    if service.social[2] != "" && service.social[2] != "https://t.me/" {
                        Link(destination: URL(string: service.social[2]) ?? URL(string: "https://t.me/")!, label: {
                            Image("telegram")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                        })
                    }
                    if service.social[3] != "" && service.social[3] != "https://www.youtube.com/" {
                        Link(destination: URL(string: service.social[3]) ?? URL(string: "https://www.youtube.com/")! , label: {
                            Image("youtube")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                        })
                    }
                    if service.social[4] != "" && service.social[4] != "https://" {
                        Link(destination: URL(string: service.social[4]) ?? URL(string: "https://")!, label: {
                            Image("webpage")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                        })
                    }
                    Spacer()
                }.padding(.bottom, 30)
                
                
                
                if !service.uid.contains("aaaaaaaaaaaaaaaaaaaaaaa") {
                    Section {
                        Button(action: {
                            isShowSheet = true
                        }) {
                            HStack(alignment: .center) {
                                Spacer()
                                Image(systemName: "person.crop.circle")
                                Text("Контактное лицо")
                                Spacer()
                            }
                        }.padding(30)
                            .sheet(isPresented: $isShowSheet) {
                                OwnerView(ownerUid: service.uid)
                            }
                    }
                }
            }
            .onAppear {
                countToArray()
            }
        }
    }
    
    func countToArray() {
        if let int = Int(count) {
            if int != 0 && int != 1 {
                for i in 2...int {
                    array.append(i-1)
                }
            }
            
        }
    }
}
