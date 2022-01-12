//
//  AddLinksView.swift
//  iosApp
//
//  Created by Sergey Lee on 2022/01/02.
//

import SwiftUI

struct AddLinksView: View {
    
    @Binding var social: [String]
    @State private var showingAlert = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        Form {
            HStack {
                Image("facebook")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                TextField("Facebook", text: $social[0])
                    .disableAutocorrection(true)
            }
            HStack {
                Image("instagram")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                TextField("Instagram", text: $social[1])
                    .disableAutocorrection(true)
            }
            HStack {
                Image("telegram")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                TextField("Телеграм канал", text: $social[2])
                    .disableAutocorrection(true)
            }
            HStack {
                Image("youtube")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                TextField("Youtube канал", text: $social[3])
                    .disableAutocorrection(true)
            }
            HStack {
                Image("webpage")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                TextField("Веб сайт", text: $social[4])
                    .disableAutocorrection(true)
            }
            
            Section {
                HStack {
                    Spacer()
                    Button(action: {
                        
                            showingAlert = true

                        
                    }, label: {
                        Text("Добавить ссылки")
                    }).alert(isPresented: $showingAlert) {
                            Alert(
                                title: Text("Ссылки добавлены! Обновите данные"),
                                dismissButton: .destructive(Text("Ок"), action: {
                                    presentationMode.wrappedValue.dismiss()
                                })
                            )
                    }
                    Spacer()
                }
            }
        }.onAppear {
            if self.social == [] || self.social == ["","","","",""] {
                self.social = ["https://www.facebook.com/", "https://www.instagram.com/", "https://t.me/", "https://www.youtube.com/", "https://"]
            }
            
        }
//        .padding(.top, 20)
    }
}

//struct AddLinksView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddLinksView()
//    }
//}
