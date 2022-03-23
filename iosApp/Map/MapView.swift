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
    
    @State var category: String = "all"
    @State var categoryName: String = "🗂"
    //    @State var isLoading: Bool = true
    @State var trackingMode: MapUserTrackingMode = .follow
    
    @StateObject var locationManager = LocationManager()
    @StateObject var serviceManager = ServiceManager()
    @State var isPresented = false
    @State var openDetails = false
    @State var appStarted = false
    @State var currentService: Service = Service(dictionary: ["name":"BOOO"])
    
    @State private var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
//    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 36.62257816899407, longitude: 127.91520089316795), span: MKCoordinateSpan(latitudeDelta: 3.5, longitudeDelta: 3.5))
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                Map(coordinateRegion: $mapRegion, interactionModes: .all, showsUserLocation: true, userTrackingMode: $trackingMode, annotationItems: serviceManager.services)
                { service in
                    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: Double(service.latitude) ?? 0.0, longitude: Double(service.longitude) ?? 0.0)) {
                        //                        NavigationLink {
                        //                            DetailsView(service: service)
                        //                        } label: {
                        if service.latitude != "" {
                            Image(service.category)
                                .renderingMode(.original)
                                .resizable()
                                .frame(width: 50, height: 50)
                                .onTapGesture {
                                    currentService = service
                                    isPresented.toggle()
                                }
                        }
                    }
                    //                    }
                    
                }
                //                .onTapGesture {
                //                    if self.isPresented == true {
                //                        isPresented.toggle()
                //                    }
                //                }
                //                .disabled(isLoading)
                .navigationTitle("Карта")
                .navigationBarTitleDisplayMode(.inline)
                //                .onAppear { self.isLoading = false }
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
                                Button("🏫 Посольства") {
                                    self.categoryName = "🏫"
                                    self.category = "embassy"
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
                                Button("💅🏼 Красота") {
                                    self.categoryName = "💅🏼"
                                    self.category = "beauty"
                                    serviceManager.category = self.category
                                    serviceManager.getServices()
                                }
                                
                            }
                            Group {
                                Button("❤️‍🩹 Здоровье") {
                                    self.categoryName = "❤️‍🩹"
                                    self.category = "health"
                                    serviceManager.category = self.category
                                    serviceManager.getServices()
                                }
                                Button("💰 Страхование/Финансы") {
                                    self.categoryName = "💰"
                                    self.category = "insurance"
                                    serviceManager.category = self.category
                                    serviceManager.getServices()
                                }
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
                            Group {
                                Button("Чхонджу") {
                                    mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 36.63926314157214, longitude: 127.47918258581026), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
                                    globalCity = "Чхонджу"
                                    serviceManager.city = globalCity
                                    serviceManager.getServices()
                                }
                                Button("Пхёнтхэк") {
                                    mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.0104484860411, longitude: 126.97948650235675), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
                                    globalCity = "Пхёнтхэк"
                                    serviceManager.city = globalCity
                                    serviceManager.getServices()
                                }
                                Button("Сосан") {
                                    mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 36.78116367382427, longitude: 126.45389687374652), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
                                    globalCity = "Сосан"
                                    serviceManager.city = globalCity
                                    serviceManager.getServices()
                                }
                                Button("Дунпо") {
                                    mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 36.927903013124414, longitude: 127.04292717110127), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
                                    globalCity = "Дунпо"
                                    serviceManager.city = globalCity
                                    serviceManager.getServices()
                                }
                                Button("Другой город") {
                                    mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 36.62257816899407, longitude: 127.91520089316795), span: MKCoordinateSpan(latitudeDelta: 3.5, longitudeDelta: 3.5))
                                    globalCity = "Другой город"
                                    serviceManager.city = globalCity
                                    serviceManager.getServices()
                                }
                            }
                            
                            
                        } label: {
                            Text(globalCity)
                                .font(.system(size: 15))
                                .minimumScaleFactor(0.1)
                        }
                    }
                }
                NavigationLink(destination: DetailsView(service: currentService), isActive: $openDetails) { EmptyView() }
                Group {
                    HStack {
                        Spacer()
                        Button(action: {
                            locationManager.requestLocation()
                            if let location = locationManager.lastLocation?.coordinate {
                                mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
                            }
                        })
                        {
                            Image(systemName: "location.circle.fill")
                                .renderingMode(.original)
                                .font(.system(size: 40))
                                .padding()
                                .shadow(color: Color.gray, radius: 1, x: 1, y: 1)
                        }
                    }
                }
            }.onAppear {
                if !appStarted {
                    if let location = locationManager.lastLocation?.coordinate {
                        mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
                    } else {
                        mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 36.62257816899407, longitude: 127.91520089316795), span: MKCoordinateSpan(latitudeDelta: 3.5, longitudeDelta: 3.5))
                    }
                }
                appStarted = true
            }
            .popup(isPresented: $isPresented) {
                Sheet {
                    NamePopupView(isPresented: $isPresented, openDetails: $openDetails,service: currentService)
                }
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}



struct OverlayModifier<OverlayView: View>: ViewModifier {
    
    @Binding var isPresented: Bool
    let overlayView: OverlayView
    
    init(isPresented: Binding<Bool>, @ViewBuilder overlayView: @escaping () -> OverlayView) {
        self._isPresented = isPresented
        self.overlayView = overlayView()
    }
    
    func body(content: Content) -> some View {
        content.overlay(isPresented ? overlayView : nil)
    }
}

extension View {
    
    func popup<OverlayView: View>(isPresented: Binding<Bool>,
                                  blurRadius: CGFloat = 0,
                                  blurAnimation: Animation? = .linear,
                                  @ViewBuilder overlayView: @escaping () -> OverlayView) -> some View {
        return blur(radius: isPresented.wrappedValue ? blurRadius : 0)
            .animation(blurAnimation)
        //            .allowsHitTesting(!isPresented.wrappedValue)
            .modifier(OverlayModifier(isPresented: isPresented, overlayView: overlayView))
    }
}
