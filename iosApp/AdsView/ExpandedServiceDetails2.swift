//
//  Service2.swift
//  iosApp
//
//  Created by Sergey Lee on 2022/01/16.
//

import Foundation
import SwiftUI

struct ExpandedServiceDetails2: View {
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
                //                if !self.arrayIm.isEmpty {
                TabView {
                    ForEach(array, id: \.self) { photo in
                        UrlImageView(urlString: service.uid + String(photo), directory: "images")
                            .scaledToFit()
                        //                            Image(uiImage: photo)
                        //                                .resizable()
                        //                                .scaledToFit()
                        //                                .frame(height: 300)
                            .cornerRadius(10)
                    }
                }
                .padding()
                .frame(height: 350)
                .cornerRadius(15)
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                .tabViewStyle(.page)
                //                } else {
                //                    Image("blank")
                //                        .padding()
                //                        .frame(height: 350)
                //                        .cornerRadius(15)
                //
                //                }
                //                UrlImageView(urlString: service.uid, directory: "images")
                //                    .scaledToFill()
                //                    .cornerRadius(15)
                //                    .padding()
                Group {
                    Text(service.name)
                        .font(.title)
                        .bold()
                        .padding(.leading, 15)
                    HStack {
                        Text("Город")
                            .font(.body)
                            .foregroundColor(.gray)
                        
                        //                    Divider()
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
                            //                        .padding(.bottom, 15)
                            //                        .padding(.trailing, 30)
                            //                        Divider()
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
                    //                    .position(x: UIScreen.main.bounds.width/2)
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
                
            }
            .onAppear {
                countToArray()
                //                sortImages() {
                //                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                //                        self.array = newArray
                //                    }
                //                }
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

