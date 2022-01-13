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
    var category: String = ""
    var children : [MenuItem]?
}

public class DataFetcher: ObservableObject {
    @Published var menuItem = [MenuItem]()
    @Published var serviceItem = [MenuItem]()

    init() {
//        var nestedMenu : [MenuItem] = []
//        for i in 0...5 {
//            nestedMenu.append(DataModel(name: "Sub Item \(i)", icon: "labor"))
//        }
        
        let workMenuItems = [ MenuItem(name: "Завод", image: "🏭", category: "zavod"),
                              MenuItem(name: "Стройка", image: "👷🏻‍♀️", category: "stroyka"),
                              MenuItem(name: "Мотель", image: "🏩", category: "motel"),
                              MenuItem(name: "Общепит", image: "🍽", category: "shchiktan"),
                              MenuItem(name: "Сельхоз работы", image: "🧑🏽‍🌾", category: "selkhoz"),
                              MenuItem(name: "Почта", image: "📦", category: "pochta"),
                              MenuItem(name: "Работа в офисе", image: "💼", category: "ofis"),
                              MenuItem(name: "Другая работа", image: "👨‍🚀", category: "rabota_drugoye")
]
        
        let carsMenuItems = [ MenuItem(name: "Hyundai", image: "🚗"),
                              MenuItem(name: "KIA", image: "🚙", category: "kia"),
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
            MenuItem(name: "Работа", image: "🛠", category: "work", children: workMenuItems),
            MenuItem(name: "Транспорт", image: "🚗", category: "transport", children: carsMenuItems),
            MenuItem(name: "Недвижимость", image: "🏢", category: "house", children: realMenuItems),
            MenuItem(name: "Телефоны и Аксессуары", image: "📱", category: "phone", children: phonesMenuItems),
            MenuItem(name: "Для дома, хобби", image: "🏠", category: "hobby", children: homeMenuItems),
            MenuItem(name: "Автозапчасти и Аксессуары", image: "⚙️", category: "car", children: carpartsMenuItems),
            MenuItem(name: "Электроника", image: "📺", category: "electronic", children: electronicsMenuItems),
            MenuItem(name: "Детские товары", image: "👶🏻", category: "children", children: childrenMenuItems),
            MenuItem(name: "Одежда", image: "👕", category: "clothes", children: clothesMenuItems),
            MenuItem(name: "Спорт, туризм и отдых", image: "🏓", category: "sport", children: sportMenuItems),
            MenuItem(name: "Домашние животные", image: "🐶", category: "pet", children: petsMenuItems),
            MenuItem(name: "Обмен, отдам бесплатно", image: "🔄", category: "change")
            ]
        
        self.serviceItem = [
            MenuItem(name: "Рестораны/Кафе", image: "🍲", category: "food"),
            MenuItem(name: "Продукты", image: "🍞", category: "shop"),
            MenuItem(name: "Связь", image: "📱", category: "connect"),
            MenuItem(name: "Образование", image: "📚", category: "study"),
            MenuItem(name: "Мероприятия/Фото/Видео", image: "🥳", category: "party"),
            MenuItem(name: "Документы/Переводы", image: "📑", category: "docs"),
            MenuItem(name: "Типография/Печать", image: "🖨", category: "design"),
            MenuItem(name: "Авто Купля/Продажа", image: "🚗", category: "cars"),
            MenuItem(name: "Красота/Здоровье", image: "💅🏼", category: "health"),
            MenuItem(name: "Трансфер/Переезд", image: "🚛", category: "transport"),
            MenuItem(name: "Туризм/Почта", image: "✈️", category: "travel"),
            MenuItem(name: "СТО/Тюнинг", image: "🧑🏻‍🔧", category: "workshop"),
            MenuItem(name: "Другое", image: "🥷", category: "other")
            
            ]
    }
}
