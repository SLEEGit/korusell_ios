//
//  Sheet.swift
//  iosApp
//
//  Created by Sergey Lee on 2022/02/15.
//

import SwiftUI

struct Sheet<Content: View>: View {
    
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                //                    .frame(width: geometry.size.width, height: geometry.size.height * 0.6)
                content
                    .padding(.bottom, geometry.safeAreaInsets.bottom)
                    .background(Color("graybg"))
                    .cornerRadius(radius: 16, corners: [.topLeft, .topRight])
                
            }
            .edgesIgnoringSafeArea([.bottom])
        }
        .animation(.easeOut)
        .transition(.move(edge: .bottom))
    }
}


struct MySpacer: View {
    
    var body: some View {
        HStack {
            
        }
        .contentShape(Rectangle())
        .onTapGesture {
            print("TEXT")
        }
    }
}

struct NamePopupView: View {
    
    @Binding var isPresented: Bool
    @Binding var openDetails: Bool
    @State var service: Service
    @State var addressCopy = false
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                UrlImageView(urlString: service.uid + "0", directory: "images")
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .onTapGesture {
                        openDetails = true
                    }
                VStack(alignment: .leading) {
                    HStack {
                        Text(service.name)
                            .font(.system(size: 15))
                            .bold()
                            .lineLimit(2)
                            .minimumScaleFactor(0.1)
                            .onTapGesture {
                                openDetails = true
                            }
                        Spacer()
                        Button(action: {
                            isPresented = false
                        }, label: {
                            Image(systemName: "xmark")
                                .foregroundColor(Color("xmark"))
                                .imageScale(.small)
                                .frame(width: 32, height: 32)
                                .background(Color("xmark").opacity(0.06))
                                .cornerRadius(16)
                            
                        })
                    }
                    if service.phone != "" {
                        HStack {
                            Text("Адрес:")
                                .font(.system(size: 13))
                                .foregroundColor(.gray)
                            Text(service.address)
                                .font(.system(size: 13))
                                .foregroundColor(.accentColor)
                                .lineLimit(1)
                                .onTapGesture {
                                    UIPasteboard.general.string = service.address
                                    addressCopy = true
                                }.alert(isPresented: $addressCopy) {
                                    Alert (
                                        title: Text("Адрес скопирован"),
                                        dismissButton: .default(Text("Ok"))
                                    )
                                    
                                }
                        }
                    }
                    
                    
                    Text(service.description)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding(.top, 5)
                        .padding(.bottom, 5)
                        .lineLimit(3)
                        .onTapGesture {
                            openDetails = true
                        }
                    if service.phone != "" {
                        HStack {
                            Button(action: {
                                Util().call(numberString: service.phone)
                            }, label: {
                                HStack {
                                    Image(systemName: "phone.fill")
                                    Text(service.phone.prefix(13))
                                        .font(.system(size: 15))
                                        .bold()
                                }
                                
                            })
                            Spacer()
                        }
                    }
                }
                .padding(.leading, 10)
            }
        }
        .padding()
    }
}

struct RoundedCornersShape: Shape {
    
    let radius: CGFloat
    let corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    
    func cornerRadius(radius: CGFloat, corners: UIRectCorner = .allCorners) -> some View {
        clipShape(RoundedCornersShape(radius: radius, corners: corners))
    }
}


