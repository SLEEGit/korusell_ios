//
//  Profile.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/12/05.
//

import SwiftUI

struct ProfileView: View {
    
    var email: String
    var uid: String
    var displayName: String
    
    var body: some View {
        VStack {
            VStack {
                Image("avatar")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 150)
                    .cornerRadius(75)
                Text(uid)
                    .font(.title)
            }
            
            Form {
                Section {
                    HStack {
                        Text("email")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Spacer()
                        Text(email)
                            .font(.caption)
                    }
                    HStack {
                        Text("phone number")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Spacer()
                        Text(displayName)
                            .font(.caption)
                    }
                    Section {
                        Button(action: {
                            
                        }) {
                            HStack(alignment: .center) {
                                Spacer()
                                Image(systemName: "pencil")
                                Text("Редактировать")
                                Spacer()
                            }
                        }
                    }
                }
            }
            
        }
    }
}
//struct Profile_Previews: PreviewProvider {
//    static var previews: some View {
//        Profile(person: example3, viewModel: viewModel)
//    }
//}

#if DEBUG
//let example3 = Person(_id: "HNyHZZjtq298izgub", avatar: "", name: "sd", username: "username", email:"asdasda", phone: "010 1233 1111")
let example3 = User(uid: "123", displayName: "dis name", email: "test@test.thisistest", avatar: "avatar", phone: "010-0000-0000")
#endif

