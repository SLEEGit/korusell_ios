//
//  StructMenu.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/11/28.
//

import Foundation

struct MenuItem1: Identifiable {
    var id = UUID()
    var name: String
    var image: String
    var subMenuItems: [MenuItem]?
}

//let sampleMenuItems = [ MenuItem(name: "РАБОТА", image: "work", subMenuItems: workMenuItems),
//                        MenuItem(name: "АВТОМОБИЛИ", image: "cars", subMenuItems: carsMenuItems),
//                        MenuItem(name: "Недвижимость", image: "real", subMenuItems: realMenuItems),
//                        MenuItem(name: "Телефоны и Аксессуары", image: "phones", subMenuItems: phonesMenuItems),
//                        MenuItem(name: "Для дома, хобби", image: "home", subMenuItems: homeMenuItems),
//                        MenuItem(name: "Автозапчасти и Аксессуары", image: "carparts", subMenuItems: carpartsMenuItems),
//                        MenuItem(name: "Электроника", image: "electronics", subMenuItems: electronicsMenuItems),
//                        MenuItem(name: "Детские товары", image: "children", subMenuItems: childrenMenuItems),
//                        MenuItem(name: "Одежда", image: "clothes", subMenuItems: clothesMenuItems),
//                        MenuItem(name: "Спорт, туризм и отдых", image: "sport", subMenuItems: sportMenuItems),
//                        MenuItem(name: "Домашние животные", image: "pets", subMenuItems: petsMenuItems),
//                        MenuItem(name: "Обмен, отдам бесплатно", image: "exchange")
//]

//let workMenuItems = [ MenuItem(name: "Завод", image: "factory"),
//                      MenuItem(name: "Стройка", image: "construction"),
//                      MenuItem(name: "Мотель", image: "motel"),
//                      MenuItem(name: "Щиктан (Общепит)", image: "food"),
//                      MenuItem(name: "Сельхоз работы", image: "farm"),
//                      MenuItem(name: "Почта", image: "labor"),
//                      MenuItem(name: "Работа в офисе", image: "office"),
//                      MenuItem(name: "Другая работа", image: "labor")
//]
//
//let carsMenuItems = [ MenuItem(name: "Hyundai", image: ""),
//                      MenuItem(name: "KIA", image: ""),
//                      MenuItem(name: "GM Chevrolet", image: ""),
//                      MenuItem(name: "Renault Samsung", image: ""),
//                      MenuItem(name: "BMW", image: ""),
//                      MenuItem(name: "Мотоциклы", image: ""),
//                      MenuItem(name: "Другие марки", image: "")
//]
//
//let realMenuItems = [ MenuItem(name: "Вонрум", image: ""),
//                      MenuItem(name: "Турум", image: ""),
//                      MenuItem(name: "Офистель", image: ""),
//                      MenuItem(name: "Апаты", image: ""),
//                      MenuItem(name: "Частный дом", image: ""),
//                      MenuItem(name: "Продажа", image: "")
//]
//
//let phonesMenuItems = [ MenuItem(name: "Смартфоны", image: ""),
//                      MenuItem(name: "Аксессуары", image: ""),
//                      MenuItem(name: "Планшеты и электронные книги", image: ""),
//                      MenuItem(name: "Умные часы и фитнес-браслеты", image: ""),
//                      MenuItem(name: "Другое", image: "")
//]
//
//let homeMenuItems = [ MenuItem(name: "Мебель", image: "factory"),
//                      MenuItem(name: "Бытовая техника", image: "construction"),
//                      MenuItem(name: "Мотель", image: "motel"),
//                      MenuItem(name: "Щиктан (Общепит)", image: "food"),
//                      MenuItem(name: "Другая работа", image: "other-work")
//]
//
//let carpartsMenuItems = [ MenuItem(name: "Аксессуары", image: "factory"),
//                      MenuItem(name: "Автозапчасти", image: "construction"),
//                      MenuItem(name: "Аудио и видеотехника", image: "motel"),
//                      MenuItem(name: "Шины, диски и колеса", image: "food"),
//                      MenuItem(name: "Другое", image: "other-work")
//]
//
//let electronicsMenuItems = [ MenuItem(name: "Аудио и видео, телевизоры", image: "factory"),
//                      MenuItem(name: "Компьютеры и ноутбуки", image: "construction"),
//                      MenuItem(name: "Игровые приставки и консоли", image: "motel"),
//                      MenuItem(name: "Фото и видеокмеры", image: "food"),
//                      MenuItem(name: "Другое", image: "other-work")
//]
//
//let childrenMenuItems = [ MenuItem(name: "Детская одежда и обувь", image: "factory"),
//                      MenuItem(name: "Игрушки", image: "construction"),
//                      MenuItem(name: "Автокресла, коляски", image: "motel"),
//                      MenuItem(name: "Детская мебель", image: "food"),
//                      MenuItem(name: "Другое", image: "other-work")
//]
//
//let clothesMenuItems = [ MenuItem(name: "Одежда и обувь", image: "factory"),
//                      MenuItem(name: "Ювелирные изделия", image: "construction"),
//                      MenuItem(name: "Рабочая одежда и средства защиты", image: "motel"),
//                      MenuItem(name: "Другое", image: "other-work")
//]
//
//let sportMenuItems = [ MenuItem(name: "Велосипеды, самокаты", image: "factory"),
//                       MenuItem(name: "Отдых и туризм", image: "construction"),
//                       MenuItem(name: "Красота и здоровье", image: "motel"),
//                       MenuItem(name: "Спортивные товары", image: "motel"),
//                       MenuItem(name: "Рыболовные принадлежности", image: "food"),
//                       MenuItem(name: "Другое", image: "other-work")
//]
//
//let petsMenuItems = [ MenuItem(name: "Собаки и кошки", image: "factory"),
//                      MenuItem(name: "Аксессуары и корм", image: "construction"),
//                      MenuItem(name: "Другие животные", image: "other-work")
//]
//
////let exchangeMenuItems = [
////                      MenuItem(name: "Другая работа", image: "other-work")
////]
