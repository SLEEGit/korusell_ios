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
    
    @StateObject private var session = Session()
    @State var list: [Service] = []
    @State var unsortedList: [Service] = []
    @State var category: String = "all"
    @State var categoryName: String = "Категории"
    @ObservedObject var locationManager = LocationManager()
    @StateObject var locationManager2 = LocationManager2()
    
    
    var userLatitude: Double { return locationManager.lastLocation?.coordinate.latitude ?? 0 }
    
    var userLongitude: Double { return locationManager.lastLocation?.coordinate.longitude ?? 0 }
    
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 36.62257816899407, longitude: 127.91520089316795), span: MKCoordinateSpan(latitudeDelta: 3.5, longitudeDelta: 3.5))
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                Map(coordinateRegion: $mapRegion, annotationItems: list) { service in
                    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: Double(service.latitude) ?? 0.0, longitude: Double(service.longitude) ?? 0.0)) {
                        NavigationLink {
                            DetailsView(service: service)
                            Text(service.name)
                        } label: {
                            VStack {
                                Text(service.name)
                                    .font(.system(size: 10))
                                    .foregroundColor(.black)
                                    .shadow(color: .white, radius: 1, x: 1, y: 1)
                                Image(systemName: "mappin.circle.fill")
                                    .renderingMode(.original)
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                
                                    .shadow(color: .gray, radius: 1, x: 1, y: 1)
                            }
                        }
                    }
                    
                }.navigationTitle("Карта")
                    .navigationBarTitleDisplayMode(.inline)
                    .onAppear {
                        list.removeAll()
                        session.fetchData(category: self.category) { (list) in
                            if globalCity == "Все города" {
                                self.list = list
                            } else if globalCity == "Другой город" {
                                self.list = list.filter { $0.city != "Чхонан" && $0.city != "Хвасонг" && $0.city != "Ансан" && $0.city != "Асан" && $0.city != "Сеул" && $0.city != "Инчхон" && $0.city != "Хвасонг"}
                            } else {
                                self.list = list.filter { $0.city == globalCity }
                            }
                            self.unsortedList = list
                        }
                    }
                
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Menu(self.categoryName) {
                                Button {
                                    self.category = "all"
                                    self.categoryName = "Все категории"
                                    self.list = unsortedList.filter { $0.city == globalCity }
                                } label: {
                                    Text("Все категории")
                                }
                                Button {
                                    self.category = "food"
                                    self.categoryName = "Рестораны/Кафе"
                                    self.list = unsortedList.filter { $0.city == globalCity && $0.category == self.category }
                                } label: {
                                    Text("Рестораны/Кафе")
                                }
                                Button {
                                    self.category = "connect"
                                    self.categoryName = "Связь"
                                    self.list = unsortedList.filter { $0.city == globalCity && $0.category == self.category }
                                } label: {
                                    Text("Связь")
                                }
                                Button {
                                    self.category = "shop"
                                    self.categoryName = "Магазины"
                                    self.list = unsortedList.filter { $0.city == globalCity && $0.category == self.category }
                                } label: {
                                    Text("Магазины")
                                }
                            }
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Menu {
                                Button {
                                    mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 36.62257816899407, longitude: 127.91520089316795), span: MKCoordinateSpan(latitudeDelta: 3.5, longitudeDelta: 3.5))
                                    self.list = self.unsortedList
                                    globalCity = "Все города"
                                    
                                } label: {
                                    Text("Все города")
                                }
                                Button {
                                    mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.31639679242606, longitude: 126.8256217710536), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
                                    self.list = self.unsortedList
                                    globalCity = "Ансан"
                                    self.list = list.filter { $0.city == globalCity }
                                } label: {
                                    Text("Ансан")
                                }
                                Button {
                                    mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.16834087290789, longitude: 126.801294705907), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
                                    self.list = self.unsortedList
                                    globalCity = "Хвасонг"
                                    self.list = list.filter { $0.city == globalCity }
                                } label: {
                                    Text("Хвасонг")
                                }
                                Button {
                                    mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.45771638152154, longitude: 126.7028438251576), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
                                    self.list = self.unsortedList
                                    globalCity = "Инчхон"
                                    self.list = list.filter { $0.city == globalCity }
                                } label: {
                                    Text("Инчхон")
                                }
                                Button {
                                    mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.52146229568448, longitude: 126.98610893732737), span: MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3))
                                    self.list = self.unsortedList
                                    globalCity = "Сеул"
                                    self.list = list.filter { $0.city == globalCity }
                                } label: {
                                    Text("Сеул")
                                }
                                Button {
                                    mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 36.7818299238274, longitude: 127.00476323050401), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
                                    self.list = self.unsortedList
                                    globalCity = "Асан"
                                    self.list = list.filter { $0.city == globalCity }
                                } label: {
                                    Text("Асан")
                                }
                                Button {
                                    mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 36.80244428186357, longitude: 127.18186756201197), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
                                    self.list = self.unsortedList
                                    globalCity = "Чхонан"
                                    self.list = list.filter { $0.city == globalCity }
                                } label: {
                                    Text("Чхонан")
                                }
                                Button {
                                    mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 36.62257816899407, longitude: 127.91520089316795), span: MKCoordinateSpan(latitudeDelta: 3.5, longitudeDelta: 3.5))
                                    self.list = self.unsortedList
                                    globalCity = "Другой город"
                                    self.list = list.filter { $0.city != "Чхонан" && $0.city != "Хвасонг" && $0.city != "Ансан" && $0.city != "Асан" && $0.city != "Сеул" && $0.city != "Инчхон" && $0.city != "Хвасонг"}
                                } label: {
                                    Text("Другой город")
                                }
                            } label: {
                                //                Image(systemName: "eye.circle")
                                Text(globalCity)
                            }
                        }
                    }
                HStack {
                    Spacer()
                    LocationButton {
                        locationManager2.requestLocation()
                    }
                    .frame(width: 60, height: 60)
                    .labelStyle(.iconOnly)
                    .symbolVariant(.fill)
                    .foregroundColor(.white)
                    .cornerRadius(30)
                }
            }
        }
    }
    
    func getCoordinates(address: String, completion: @escaping (CLLocationCoordinate2D?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) {
            (placemarks, error) in
            guard error == nil else {
                print("Geocoding error: \(error!)")
                completion(nil)
                return
            }
            completion(placemarks?.first?.location?.coordinate)
        }
    }
}

struct MapView2_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
