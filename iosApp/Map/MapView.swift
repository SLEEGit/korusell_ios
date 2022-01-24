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

struct MapView: View {
    
    @StateObject private var session = DB()
    @State var list: [Service] = []
    @State var category: String = "all"
    @State var categoryName: String = "🗂"
    @State var isLoading: Bool = true
    @State var trackingMode: MapUserTrackingMode = .follow
    
    @StateObject var locationManager = LocationManager()
    @StateObject var serviceManager = ServiceManager()
    
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 36.62257816899407, longitude: 127.91520089316795), span: MKCoordinateSpan(latitudeDelta: 3.5, longitudeDelta: 3.5))
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                Map(coordinateRegion: $mapRegion, interactionModes: .all, showsUserLocation: true, userTrackingMode: $trackingMode, annotationItems: serviceManager.services)
            { service in
                    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: Double(service.latitude) ?? 0.0, longitude: Double(service.longitude) ?? 0.0)) {
                        NavigationLink {
                            DetailsView(service: service)
                        } label: {
                            VStack {
                                if service.latitude != "" {
//                                    if service.category == "health" {
//                                        Text("💅🏼")
//                                    } else if service.category == "food" {
//                                            Text("🍽")
//                                            .border(Color.red)
//                                    } else {
                                        Image(systemName: "mappin.circle.fill")
                                            .renderingMode(.original)
                                            .resizable()
                                            .frame(width: 25, height: 25)
    //                                        .shadow(color: .gray, radius: 1, x: 1, y: 1)
//                                    }
                                    
                                }

                            }
                        }
                    }
                    
                }.disabled(isLoading)
                    .navigationTitle("Карта")
                    .navigationBarTitleDisplayMode(.inline)
                    .onAppear {
                            self.isLoading = false
                    }
                
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Menu {
                                Group {
                                    Button("🗂 Все категории") {
                                        self.categoryName = "🗂"
                                        self.category = "all"
                                        serviceManager.category = self.category
                                        serviceManager.getServices()
                                    }
                                    Button("🍲 Рестораны/Кафе") {
                                        self.categoryName = "🍲"
                                        self.category = "food"
                                        serviceManager.category = self.category
                                        serviceManager.getServices()
                                    }
                                    Button("🍞 Продукты") {
                                        self.categoryName = "🍞"
                                        self.category = "shop"
                                        serviceManager.category = self.category
                                        serviceManager.getServices()
                                    }
                                    Button("📱 Связь/Электроника") {
                                        self.categoryName = "📱"
                                        self.category = "connect"
                                        serviceManager.category = self.category
                                        serviceManager.getServices()
                                    }
                                    
                                    Button("📚 Образование") {
                                        self.categoryName = "📚"
                                        self.category = "study"
                                        serviceManager.category = self.category
                                        serviceManager.getServices()
                                    }
                                    Button("🥳 Мероприятия/Фото/Видео") {
                                        self.categoryName = "🥳"
                                        self.category = "party"
                                        serviceManager.category = self.category
                                        serviceManager.getServices()
                                    }
                                    Button("📑 Документы/Переводы") {
                                        self.categoryName = "📑"
                                        self.category = "docs"
                                        serviceManager.category = self.category
                                        serviceManager.getServices()
                                    }
                                    Button("🚗 Авто Купля/Продажа") {
                                        self.categoryName = "🚗"
                                        self.category = "cars"
                                        serviceManager.category = self.category
                                        serviceManager.getServices()
                                    }
                                    Button("💅🏼 Красота/Здоровье") {
                                        self.categoryName = "💅🏼"
                                        self.category = "health"
                                        serviceManager.category = self.category
                                        serviceManager.getServices()
                                    }
                                }
                                Group {
                                    Button("🚛 Трансфер/Переезд") {
                                        self.categoryName = "🚛"
                                        self.category = "transport"
                                        serviceManager.category = self.category
                                        serviceManager.getServices()
                                    }
                                    Button("✈️ Туризм/Почта") {
                                        self.categoryName = "✈️"
                                        self.category = "travel"
                                        serviceManager.category = self.category
                                        serviceManager.getServices()
                                    }
                                    Button("🧑🏻‍🔧 СТО/Тюнинг") {
                                        self.categoryName = "🧑🏻‍🔧"
                                        self.category = "workshop"
                                        serviceManager.category = self.category
                                        serviceManager.getServices()
                                    }
                                    Button("🥷 Другие услуги") {
                                        self.categoryName = "🥷"
                                        self.category = "other"
                                        serviceManager.category = self.category
                                        serviceManager.getServices()
                                    }
                                    Button("🪆 Другие товары") {
                                        self.categoryName = "🪆"
                                        self.category = "products"
                                        serviceManager.category = self.category
                                        serviceManager.getServices()
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
                                    serviceManager.city = globalCity
                                    serviceManager.getServices()
                                }
                                Button("Ансан") {
                                    mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.31639679242606, longitude: 126.8256217710536), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
                                    globalCity = "Ансан"
                                    serviceManager.city = globalCity
                                    serviceManager.getServices()
                                }
                                Button("Хвасонг") {
                                    mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.16834087290789, longitude: 126.801294705907), span: MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3))
                                    globalCity = "Хвасонг"
                                    serviceManager.city = globalCity
                                    serviceManager.getServices()
                                }
                                Button("Инчхон") {
                                    mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.45771638152154, longitude: 126.7028438251576), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
                                    globalCity = "Инчхон"
                                    serviceManager.city = globalCity
                                    serviceManager.getServices()
                                }
                                Button("Сеул") {
                                    mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.52146229568448, longitude: 126.98610893732737), span: MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3))
                                    globalCity = "Сеул"
                                    serviceManager.city = globalCity
                                    serviceManager.getServices()
                                }
                                Button("Сувон") {
                                    mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.28338391588353, longitude: 127.01187706655084), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
                                    globalCity = "Сувон"
                                    serviceManager.city = globalCity
                                    serviceManager.getServices()
                                }
                                Button("Асан") {
                                    mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 36.7818299238274, longitude: 127.00476323050401), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
                                    globalCity = "Асан"
                                    serviceManager.city = globalCity
                                    serviceManager.getServices()
                                }
                                Button("Чхонан") {
                                    mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 36.80244428186357, longitude: 127.18186756201197), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
                                    globalCity = "Чхонан"
                                    serviceManager.city = globalCity
                                    serviceManager.getServices()
                                }
                                Button("Чхонджу") {
                                    mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 36.63926314157214, longitude: 127.47918258581026), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
                                    globalCity = "Чхонджу"
                                    serviceManager.city = globalCity
                                    serviceManager.getServices()
                                }
                                Button("Другой город") {
                                    mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 36.62257816899407, longitude: 127.91520089316795), span: MKCoordinateSpan(latitudeDelta: 3.5, longitudeDelta: 3.5))
                                    globalCity = "Другой город"
                                    serviceManager.city = globalCity
                                    serviceManager.getServices()
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
