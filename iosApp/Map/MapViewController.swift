//
//  MapViewController.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/12/13.
//

import Foundation
import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    var mapView: MKMapView!
    
    var title2: UILabel!
    var info2: UILabel!
    
    let london = Marker(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics.")
    let oslo = Marker(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago.")
    let paris = Marker(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light.")
    let rome = Marker(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.")
    let washington = Marker(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.")

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mapView)
        let oahuCenter = CLLocation(latitude: 51.507222, longitude: -0.1275)
        let region = MKCoordinateRegion(center: oahuCenter.coordinate, latitudinalMeters: 50000, longitudinalMeters: 60000)
        mapView.setCameraBoundary(MKMapView.CameraBoundary(coordinateRegion: region), animated: true)
        
        // For getting location while tapping on map we need to add UITapGestureRecognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        
        // mapView is the outlet of map
        mapView.addGestureRecognizer(tapGesture)
        // Do any additional setup after loading the view, typically from a nib.
        
        mapView.addAnnotations([london, oslo, paris, rome, washington])
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 1
        guard annotation is Marker else { return nil }

        // 2
        let identifier = "Marker"

        // 3
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if annotationView == nil {
            //4
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
//            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true

            // 5
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
//            annotationView?.image = UIImage(systemName: "house")
        } else {
            // 6
            annotationView?.annotation = annotation
        }

        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let marker = view.annotation as? Marker else { return }
        let placeName = marker.title
        let placeInfo = marker.info

        print(placeInfo)
        print(placeName ?? "")

        title2.text = placeName
        info2.text = placeInfo
        
//        let vc = TestViewController()
//        vc.text1 = placeName ?? ""
//        vc.text2 = placeInfo
//        self.present(vc, animated: true)
//        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
//        ac.addAction(UIAlertAction(title: "OK", style: .default))
//        present(ac, animated: true)
    }
    
    @objc func handleTap(gestureReconizer: UITapGestureRecognizer) {
            
            let location = gestureReconizer.location(in: mapView)
            let coordinate = mapView.convert(location,toCoordinateFrom: mapView)
            
            // Add annotation:
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            print(" Coordinates ======= \(coordinate)")
            
            /* to show only one pin while tapping on map by removing the last.
            If you want to show multiple pins you can remove this piece of code */
            if mapView.annotations.count == 1 {
                mapView.removeAnnotation(mapView.annotations.last!)
            }
            mapView.addAnnotation(annotation) // add annotaion pin on the map
        }


}

class Marker: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
}

