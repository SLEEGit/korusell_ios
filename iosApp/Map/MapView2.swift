//
//  MapView2.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/12/13.
//

import SwiftUI
import MapKit

struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct ServiceLocationJSON: Identifiable, Decodable{
    var id: Int
    var LATITUDE: Double
    var LONGITUDE: Double
    var DEALER_NAME: String
    var DEALER_ADDRESS: String
    var DEALER_PICTURE: String
    var PHONE: String
}

struct MapView2: View {
    
    @State var serviceLocation: [ServiceLocationJSON] = []
    @StateObject private var session = Session()
    @State private var globalList: [Service] = []
    @State var locations = [
        Location(name: "Buckingham Palace", coordinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141)),
        Location(name: "Tower of London", coordinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076))
    ]
    
    
    
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.5, longitude: -0.12), span: MKCoordinateSpan(latitudeDelta: 1.2, longitudeDelta: 1.2))

    
    var body: some View {
        NavigationView {
//           ЗДЕСЬ РАБОТАЕТ ТАКАЯ СТРУКТУРА!
//            Map(coordinateRegion: $mapRegion, interactionModes: .all, showsUserLocation: true, userTrackingMode: .none, annotationItems: serviceLocation) { location in
            Map(coordinateRegion: $mapRegion, annotationItems: locations) { location in
                MapAnnotation(coordinate: location.coordinate) {
                    NavigationLink {
                        ServiceView(service: globalList.filter { $0._id == location.name }.first)
//                        Text(location.name)
                    } label: {
                        VStack {
                            Text(location.name)
                                .font(.system(size: 5))
                                .foregroundColor(.black)
                                .shadow(color: .gray, radius: 1, x: 1, y: 1)
                            Image(systemName: "pin.fill")
                                .resizable()
                                .frame(width: 20, height: 35)
                                .foregroundColor(.red)
                                .shadow(color: .gray, radius: 1, x: 1, y: 1)
              
                        }
                    }
                }
            }
            .navigationTitle("Карта")
        }.onAppear {
            session.fetchData(category: "all") { (list) in
                globalList = list
                for i in globalList {
                    getCoordinates(forAddress: i.address) { (coo) in
                        locations.append(Location(name: i._id, coordinate: coo ?? CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076)))
                            print(coo)
                    }
                }
            }
        }
    }
    
    func getCoordinates(forAddress address: String, completion: @escaping (CLLocationCoordinate2D?) -> Void) {
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
        MapView2()
    }
}
