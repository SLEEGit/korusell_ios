//
//  MapView.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/12/13.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @StateObject private var session = Session()
    @State var list: [Service] = []
    @State var unsortedList: [Service] = []
    
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.5, longitude: -0.12), span: MKCoordinateSpan(latitudeDelta: 1.2, longitudeDelta: 1.2))
    
    var body: some View {
        NavigationView {
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
                    print(globalCity)
                    list.removeAll()
                    session.fetchData(category: "all") { (list) in
                        if globalCity == "Все города" {
                            self.list = list
                            mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 36.62257816899407, longitude: 127.91520089316795), span: MKCoordinateSpan(latitudeDelta: 3.5, longitudeDelta: 3.5))
                        } else if globalCity == "Другой город" {
                            self.list = list.filter { $0.city != "Чхонан" && $0.city != "Хвасонг" && $0.city != "Ансан" && $0.city != "Асан" && $0.city != "Сеул" && $0.city != "Инчхон" && $0.city != "Хвасонг"}
                        } else {
                            self.list = list.filter { $0.city == globalCity }
                        }
                        self.unsortedList = list
                        
//                        mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: Double(list.first!.latitude)!, longitude: Double(list.first!.longitude)!), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
                        
                        //                        for i in list {
                        //                            getCoordinates(address: i.address) { (coo) in
                        //                            self.list.append(i)
                        //                            }
                        //                        }
                    }
                }
            
                .toolbar{
                    Menu {
                        Button {
                            self.list = self.unsortedList
                            globalCity = "Все города"
                            mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 36.62257816899407, longitude: 127.91520089316795), span: MKCoordinateSpan(latitudeDelta: 3.5, longitudeDelta: 3.5))
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
                            self.list = self.unsortedList
                            globalCity = "Хвасонг"
                            self.list = list.filter { $0.city == globalCity }
                        } label: {
                            Text("Хвасонг")
                        }
                        Button {
                            self.list = self.unsortedList
                            globalCity = "Инчхон"
                            self.list = list.filter { $0.city == globalCity }
                        } label: {
                            Text("Инчхон")
                        }
                        Button {
                            self.list = self.unsortedList
                            globalCity = "Сеул"
                            self.list = list.filter { $0.city == globalCity }
                        } label: {
                            Text("Сеул")
                        }
                        Button {
                            self.list = self.unsortedList
                            globalCity = "Асан"
                            self.list = list.filter { $0.city == globalCity }
                        } label: {
                            Text("Асан")
                        }
                        Button {
                            self.list = self.unsortedList
                            globalCity = "Чхонан"
                            self.list = list.filter { $0.city == globalCity }
                        } label: {
                            Text("Чхонан")
                        }
                        Button {
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
