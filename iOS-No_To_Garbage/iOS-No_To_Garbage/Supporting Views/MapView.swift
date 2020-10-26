//
//  MapView.swift
//  iOS-No_To_Garbage
//CLLocationCoordinate2D
//  Created by Admin on 18.10.2020.
//

import SwiftUI
import MapKit
struct MapView: UIViewRepresentable {
    
    var coordinate: [CLLocationCoordinate2D]
    var hint:[String]
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        let region = MKCoordinateRegion(center: coordinate[coordinate.count-1], span: span)
        uiView.setRegion(region, animated: true)
        for i in 0...coordinate.count-1{
            print(coordinate.count)
            print(hint)
            print(coordinate)
            let annotation = MKPointAnnotation()
            annotation.title = hint[i]
            annotation.subtitle = hint[i]
            annotation.coordinate = coordinate[i]
            uiView.addAnnotation(annotation)
        }
        
        
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        let coordinate = [CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)]
        let hint = ["hint 0"]
        MapView(coordinate: coordinate, hint: hint)
    }
}
