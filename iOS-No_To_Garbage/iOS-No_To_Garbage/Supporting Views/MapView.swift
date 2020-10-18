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
        let region = MKCoordinateRegion(center: coordinate[0], span: span)
        uiView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.title = hint[0]
        annotation.subtitle = "One day I'll go here..."
        annotation.coordinate = coordinate[0]
        uiView.addAnnotation(annotation)
        
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        let coordinate = [CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)]
        let hint = ["hint 0"]
        MapView(coordinate: coordinate, hint: hint)
    }
}
