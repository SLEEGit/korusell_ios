//
//  MapView.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/12/13.
//

import SwiftUI
import MapKit

//struct MapView: View {
//
//    @State private var city: String = "Все города"
//
//    var body: some View {
//        Text(city)
//            .onAppear {
//                city = globalCity
//            }
//    }
//
//}

struct City: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    
   
}

struct MapView: View {
    
    @StateObject private var session = Session()
    
    @State private var cities: [City] = []

    @State private var userTrackingMode: MapUserTrackingMode = .follow
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 25.7617, longitude: 80.1918),
        span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
    )

    var body: some View {
        PinsView(viewModel: PinsViewModel(cities: cities))
            .onAppear {
                session.fetchData(category: "food") { (list) in
                    for i in list {
                        
//                        coordinates(forAddress: i.address) { (coo) in
//                            print(i.address)
//                            cities.append(City(coordinate: coo ?? .init(latitude: 47.6062, longitude: 122.3321)))
//                        }
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

final class PinsViewModel: ObservableObject {
    @Published var mapRect = MKMapRect()
    let cities: [City]

    init(cities: [City]) {
        self.cities = cities
    }

    func fit() {
        let points = cities.map(\.coordinate).map(MKMapPoint.init)
        mapRect = points.reduce(MKMapRect.null) { rect, point in
            let newRect = MKMapRect(origin: point, size: MKMapSize())
            return rect.union(newRect)
        }
    }
    
    
}

struct PinsView: View {
    @ObservedObject var viewModel: PinsViewModel

    var body: some View {
        Map(
            mapRect: $viewModel.mapRect,
            annotationItems: viewModel.cities
        ) { city in
            MapPin(coordinate: city.coordinate, tint: .black)
        }
        .onTapGesture {
            print("Tap")
        }
        .onAppear(perform: viewModel.fit)
    }
}

