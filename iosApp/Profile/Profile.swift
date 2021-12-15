//
//  Profile.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/12/05.
//

import SwiftUI

struct Profile: View {
    
    var person: Person!
    
    var body: some View {
        VStack {
            //                Later change to individual image
            VStack {
                Image(person.avatar)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 150)
                    .cornerRadius(75)
                Text(person.name)
                    .font(.title)
            }
            
            Form {
                Section {
                    HStack {
                        Text("email")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Spacer()
                        Text(person.email)
                            .font(.caption)
                    }
                    HStack {
                        Text("phone number")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Spacer()
                        Text(person.phone)
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
struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}

#if DEBUG
let example3 = Person(_id: "HNyHZZjtq298izgub", avatar: "", name: "sd", username: "username", email:"asdasda", phone: "010 1233 1111")
#endif

