//
//  DataFetch.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/11/30.
//

import Foundation

struct MenuItem: Identifiable{
    var id = UUID()
    var name: String
    var image: String
    var children : [MenuItem]?
}

public class DataFetcher: ObservableObject {
    @Published var menuItem = [MenuItem]()

    init() {
//        var nestedMenu : [MenuItem] = []
//        for i in 0...5 {
//            nestedMenu.append(DataModel(name: "Sub Item \(i)", icon: "labor"))
//        }
        
        let workMenuItems = [ MenuItem(name: "Завод", image: "🏭"),
                              MenuItem(name: "Стройка", image: "👷🏻‍♀️"),
                              MenuItem(name: "Мотель", image: "🏩"),
                              MenuItem(name: "Общепит", image: "🍽"),
                              MenuItem(name: "Сельхоз работы", image: "🧑🏽‍🌾"),
                              MenuItem(name: "Почта", image: "📦"),
                              MenuItem(name: "Работа в офисе", image: "💼"),
                              MenuItem(name: "Другая работа", image: "👨‍🚀")
        ]

        let carsMenuItems = [ MenuItem(name: "Hyundai", image: "🚗"),
                              MenuItem(name: "KIA", image: "🚙"),
                              MenuItem(name: "GM Chevrolet", image: "🚘"),
                              MenuItem(name: "Renault Samsung", image: "🛻"),
                              MenuItem(name: "BMW", image: "🏎"),
                              MenuItem(name: "Мотоциклы", image: "🏍"),
                              MenuItem(name: "Другие марки", image: "🚜")
        ]

        let realMenuItems = [ MenuItem(name: "Вонрум", image: "⛺️"),
                              MenuItem(name: "Турум", image: "🛖"),
                              MenuItem(name: "Офистель", image: "🏬"),
                              MenuItem(name: "Апаты", image: "🏢"),
                              MenuItem(name: "Частный дом", image: "🏠"),
                              MenuItem(name: "Продажа", image: "🏷")
        ]

        let phonesMenuItems = [ MenuItem(name: "Смартфоны", image: "📱"),
                              MenuItem(name: "Аксессуары", image: "🎧"),
                              MenuItem(name: "Планшеты и электронные книги", image: "📱"),
                              MenuItem(name: "Умные часы и фитнес-браслеты", image: "⌚️"),
                              MenuItem(name: "Другое", image: "☎️")
        ]

        let homeMenuItems = [ MenuItem(name: "Мебель", image: "🛋"),
                              MenuItem(name: "Бытовая техника", image: "📻"),
                              MenuItem(name: "Музыкальные инструменты", image: "🎸"),
                              MenuItem(name: "Книги", image: "📖"),
                              MenuItem(name: "Другое", image: "🪴")
        ]

        let carpartsMenuItems = [ MenuItem(name: "Аксессуары", image: "🪛"),
                              MenuItem(name: "Автозапчасти", image: "⚙️"),
                              MenuItem(name: "Аудио и видеотехника", image: "🔈"),
                              MenuItem(name: "Шины, диски и колеса", image: "𐃏"),
                              MenuItem(name: "Другое", image: "⛽️")
        ]

        let electronicsMenuItems = [ MenuItem(name: "Аудио и видео, телевизоры", image: "🎥"),
                              MenuItem(name: "Компьютеры и ноутбуки", image: "💻"),
                              MenuItem(name: "Игровые приставки и консоли", image: "🎮"),
                              MenuItem(name: "Фото и видеокмеры", image: "📷"),
                              MenuItem(name: "Другое", image: "⌨️")
        ]

        let childrenMenuItems = [ MenuItem(name: "Детская одежда и обувь", image: "👗"),
                              MenuItem(name: "Игрушки", image: "🧸"),
                              MenuItem(name: "Автокресла, коляски", image: "💺"),
                              MenuItem(name: "Детская мебель", image: "🛏"),
                              MenuItem(name: "Другое", image: "👶🏻")
        ]

        let clothesMenuItems = [ MenuItem(name: "Одежда и обувь", image: "👟"),
                              MenuItem(name: "Ювелирные изделия", image: "💍"),
                              MenuItem(name: "Рабочая одежда и средства защиты", image: "🦺"),
                              MenuItem(name: "Другое", image: "🧤")
        ]

        let sportMenuItems = [ MenuItem(name: "Велосипеды, самокаты", image: "🚴‍♂️"),
                               MenuItem(name: "Отдых и туризм", image: "🏕"),
                               MenuItem(name: "Красота и здоровье", image: "💄"),
                               MenuItem(name: "Спортивные товары", image: "🏓"),
                               MenuItem(name: "Рыболовные принадлежности", image: "🎣"),
                               MenuItem(name: "Другое", image: "🎿")
        ]

        let petsMenuItems = [ MenuItem(name: "Собаки и кошки", image: "🐶"),
                              MenuItem(name: "Аксессуары и корм", image: "🧫"),
                              MenuItem(name: "Другие животные", image: "🐹")
        ]
        
        self.menuItem = [
            MenuItem(name: "Работа", image: "🛠", children: workMenuItems),
            MenuItem(name: "Автомобили", image: "🚗", children: carsMenuItems),
            MenuItem(name: "Недвижимость", image: "🏢", children: realMenuItems),
            MenuItem(name: "Телефоны и Аксессуары", image: "📱", children: phonesMenuItems),
            MenuItem(name: "Для дома, хобби", image: "🏠", children: homeMenuItems),
            MenuItem(name: "Автозапчасти и Аксессуары", image: "⚙️", children: carpartsMenuItems),
            MenuItem(name: "Электроника", image: "📺", children: electronicsMenuItems),
            MenuItem(name: "Детские товары", image: "👶🏻", children: childrenMenuItems),
            MenuItem(name: "Одежда", image: "👕", children: clothesMenuItems),
            MenuItem(name: "Спорт, туризм и отдых", image: "🏓", children: sportMenuItems),
            MenuItem(name: "Домашние животные", image: "🐶", children: petsMenuItems),
            MenuItem(name: "Обмен, отдам бесплатно", image: "🔄")
            ]
    }
}
