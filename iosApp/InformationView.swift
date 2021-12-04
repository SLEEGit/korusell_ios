//
//  InformationView.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/12/02.
//

import SwiftUI

struct InformationView: View {
    var body: some View {
        Text("Привет! Очень рады что ты присоединился к нам! Мы будем стараться делать наше приложение только лучше. Если у тебя возникли какие либо вопросы, пожалуйста, обращайся на почту: почта@почта.ру")
            .padding()
            .font(.title2)
            .navigationTitle("Info")
        Spacer()
    }
}

struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView()
    }
}
