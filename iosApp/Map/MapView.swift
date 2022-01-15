//
//  MapView.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/12/13.
//

import SwiftUI
import MapKit
import CoreLocation
import CoreLocationUI

//struct catModel: Hashable {
//    var id = UUID()
//    let category: String
//    let name: String
//}

struct MapView: View {
    
    @StateObject private var session = DB()
    @State var list: [Service] = []
    @State var category: String = "all"
    @State var categoryName: String = "🗂"
    @State var isLoading: Bool = true
    @State var trackingMode: MapUserTrackingMode = .follow
    
    @StateObject var locationManager = LocationManager()
    
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 36.62257816899407, longitude: 127.91520089316795), span: MKCoordinateSpan(latitudeDelta: 3.5, longitudeDelta: 3.5))
    
//    let categories: [catModel] = [
//        catModel(category: "Все категории", name: "all"),
//        catModel(category: "Рестораны/Кафе", name: "food"),
//        catModel(category: "Связь", name: "connect"),
//        catModel(category: "Магазины", name: "shop"),
//        catModel(category: "Документы/Переводы", name: "docs"),
//        catModel(category: "Юридические услуги", name: "law"),
//        catModel(category: "Мероприятия/Фото/Видео", name: "party"),
//        catModel(category: "Красота/Здоровье", name: "health"),
//        catModel(category: "СТО/Тюнинг", name: "workshop")
//        catModel(category: "Транспорт/Переезд", name: "transport"),
//        catModel(category: "Няни/Детсад", name: "nanny"),
//        catModel(category: "Образование", name: "study"),
//        catModel(category: "Туризм", name: "tourism")
        
//    ]
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                Map(coordinateRegion: $mapRegion, interactionModes: .all, showsUserLocation: true, userTrackingMode: $trackingMode, annotationItems: list)
            { service in
                    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: Double(service.latitude) ?? 0.0, longitude: Double(service.longitude) ?? 0.0)) {
                        NavigationLink {
                            DetailsView(service: service)
                        } label: {
                            VStack {
//                                Text(service.name)
//                                    .font(.system(size: 10))
//                                    .foregroundColor(.black)
//                                    .shadow(color: .white, radius: 1, x: 1, y: 1)
                                if service.latitude != "" {
                                    Image(systemName: "mappin.circle.fill")
                                        .renderingMode(.original)
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                        .shadow(color: .gray, radius: 1, x: 1, y: 1)
                                }

                            }
                        }
                    }
                    
                }.disabled(isLoading)
                    .navigationTitle("Карта")
                    .navigationBarTitleDisplayMode(.inline)
                    .onAppear {
//                        locationManager.requestLocation()
                        session.getServices(category: "all") { (list) in
                            globalServices = list
                            self.isLoading = false
                        }
                        
                        //                        self.category = globalCategory
                        //                        if globalCategory == "docs" {
                        //                            self.categoryName = "Документы/Переводы"
                        //                        }
                        self.list = Util().filter(city: globalCity, category: self.category, unsortedList: globalServices)
                    }
                
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Menu {
                                Group {
                                    Button("🗂 Все категории") {
                                        self.categoryName = "🗂"
                                        self.category = "all"
                                        self.list = Util().filter(city: globalCity, category: self.category, unsortedList: globalServices)
                                    }
                                    Button("🍲 Рестораны/Кафе") {
                                        self.categoryName = "🍲"
                                        self.category = "food"
                                        self.list = Util().filter(city: globalCity, category: self.category, unsortedList: globalServices)
                                    }
                                    Button("🍞 Продукты") {
                                        self.categoryName = "🍞"
                                        self.category = "shop"
                                        self.list = Util().filter(city: globalCity, category: self.category, unsortedList: globalServices)
                                    }
                                    Button("📱 Связь/Электроника") {
                                        self.categoryName = "📱"
                                        self.category = "connect"
                                        self.list = Util().filter(city: globalCity, category: self.category, unsortedList: globalServices)
                                    }
                                    
                                    Button("📚 Образование") {
                                        self.categoryName = "📚"
                                        self.category = "study"
                                        self.list = Util().filter(city: globalCity, category: self.category, unsortedList: globalServices)
                                    }
                                    Button("🥳 Мероприятия/Фото/Видео") {
                                        self.categoryName = "🥳"
                                        self.category = "party"
                                        self.list = Util().filter(city: globalCity, category: self.category, unsortedList: globalServices)
                                    }
                                    Button("📑 Документы/Переводы") {
                                        self.categoryName = "📑"
                                        self.category = "docs"
                                        self.list = Util().filter(city: globalCity, category: self.category, unsortedList: globalServices)
                                    }
                                    Button("🚗 Авто Купля/Продажа") {
                                        self.categoryName = "🚗"
                                        self.category = "cars"
                                        self.list = Util().filter(city: globalCity, category: self.category, unsortedList: globalServices)
                                    }
                                    Button("💅🏼 Красота/Здоровье") {
                                        self.categoryName = "💅🏼"
                                        self.category = "health"
                                        self.list = Util().filter(city: globalCity, category: self.category, unsortedList: globalServices)
                                    }
                                }
                                Group {
                                    Button("🚛 Трансфер/Переезд") {
                                        self.categoryName = "🚛"
                                        self.category = "transport"
                                        self.list = Util().filter(city: globalCity, category: self.category, unsortedList: globalServices)
                                    }
                                    Button("✈️ Туризм/Почта") {
                                        self.categoryName = "✈️"
                                        self.category = "travel"
                                        self.list = Util().filter(city: globalCity, category: self.category, unsortedList: globalServices)
                                    }
                                    Button("🧑🏻‍🔧 СТО/Тюнинг") {
                                        self.categoryName = "🧑🏻‍🔧"
                                        self.category = "workshop"
                                        self.list = Util().filter(city: globalCity, category: self.category, unsortedList: globalServices)
                                    }
                                    Button("🥷 Другие услуги") {
                                        self.categoryName = "🥷"
                                        self.category = "other"
                                        self.list = Util().filter(city: globalCity, category: self.category, unsortedList: globalServices)
                                    }
                                    Button("🪆 Другие товары") {
                                        self.categoryName = "🪆"
                                        self.category = "products"
                                        self.list = Util().filter(city: globalCity, category: self.category, unsortedList: globalServices)
                                    }
                                }
                            } label: {
                                Text(self.categoryName)
                                    .font(.system(size: 25))
                                    .minimumScaleFactor(0.1)
                            }
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Menu {
                                Button("Все города") {
                                    mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 36.62257816899407, longitude: 127.91520089316795), span: MKCoordinateSpan(latitudeDelta: 3.5, longitudeDelta: 3.5))
                                    globalCity = "Все города"
                                    self.list = Util().filter(city: globalCity, category: self.category, unsortedList: globalServices)
                                }
                                Button("Ансан") {
                                    mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.31639679242606, longitude: 126.8256217710536), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
                                    globalCity = "Ансан"
                                    self.list = Util().filter(city: globalCity, category: self.category, unsortedList: globalServices)
                                }
                                Button("Хвасонг") {
                                    mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.16834087290789, longitude: 126.801294705907), span: MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3))
                                    globalCity = "Хвасонг"
                                    self.list = Util().filter(city: globalCity, category: self.category, unsortedList: globalServices)
                                }
                                Button("Инчхон") {
                                    mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.45771638152154, longitude: 126.7028438251576), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
                                    globalCity = "Инчхон"
                                    self.list = Util().filter(city: globalCity, category: self.category, unsortedList: globalServices)
                                }
                                Button("Сеул") {
                                    mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.52146229568448, longitude: 126.98610893732737), span: MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3))
                                    globalCity = "Сеул"
                                    self.list = Util().filter(city: globalCity, category: self.category, unsortedList: globalServices)
                                }
                                Button("Сувон") {
                                    mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.28338391588353, longitude: 127.01187706655084), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
                                    globalCity = "Сувон"
                                    self.list = Util().filter(city: globalCity, category: self.category, unsortedList: globalServices)
                                }
                                Button("Асан") {
                                    mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 36.7818299238274, longitude: 127.00476323050401), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
                                    globalCity = "Асан"
                                    self.list = Util().filter(city: globalCity, category: self.category, unsortedList: globalServices)
                                }
                                Button("Чхонан") {
                                    mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 36.80244428186357, longitude: 127.18186756201197), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
                                    globalCity = "Чхонан"
                                    self.list = Util().filter(city: globalCity, category: self.category, unsortedList: globalServices)
                                }
                                Button("Другой город") {
                                    mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 36.62257816899407, longitude: 127.91520089316795), span: MKCoordinateSpan(latitudeDelta: 3.5, longitudeDelta: 3.5))
                                    globalCity = "Другой город"
                                    self.list = Util().filter(city: globalCity, category: self.category, unsortedList: globalServices)
                                }
                            } label: {
                                Text(globalCity)
                                    .font(.system(size: 15))
                                    .minimumScaleFactor(0.1)
                            }
                        }
                    }
                Group {
                HStack {
                    Spacer()
//                    if #available(iOS 15.0, *) {
//                        LocationButton {
//                            locationManager.requestLocation()
//                            if let location = locationManager.lastLocation?.coordinate {
//
//                                mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
//                            }
//                        }
//                        .labelStyle(.iconOnly)
//                        .symbolVariant(.fill)
//                        .cornerRadius(30)
//                        .foregroundColor(.white)
//                        .frame(width: 60, height: 60)
//                        .shadow(color: Color.gray, radius: 1, x: 1, y: 1)
//                        .padding()
//                    } else {
                        Button(action: {
                            locationManager.requestLocation()
                            if let location = locationManager.lastLocation?.coordinate {
                                mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
                            }
                        })
                        {
                            Image(systemName: "location.circle.fill")
                                .renderingMode(.original)
                                .font(.system(size: 40))
                                .padding()
                                .shadow(color: Color.gray, radius: 1, x: 1, y: 1)
                        }
//                    }
            
                }
                }
            }
            if isLoading {
                ProgressView().progressViewStyle(CircularProgressViewStyle(tint: Color("textColor")))
                    .background(Color(UIColor.systemGroupedBackground).opacity(0.1))
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
