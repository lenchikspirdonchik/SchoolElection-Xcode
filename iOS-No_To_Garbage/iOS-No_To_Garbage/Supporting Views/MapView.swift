//
//  MapView.swift
//  iOS-No_To_Garbage
//CLLocationCoordinate2D
//  Created by Admin on 18.10.2020.
//

import SwiftUI
import MapKit
struct MapView: UIViewRepresentable {
    var resArray: [(CLLocationCoordinate2D, String, String)]
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        if (resArray.isEmpty){
            print("Waiting...")
        }
        else{
        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        let region = MKCoordinateRegion(center: resArray[0].0, span: span)
        uiView.setRegion(region, animated: true)
        for i in 0...resArray.count-1{
            let coordinate = resArray[i].0
            let hint = resArray[i].2
            let annotation = MKPointAnnotation()
            annotation.title = hint
            annotation.coordinate = coordinate
            uiView.addAnnotation(annotation)
            
        }
        }
        
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(resArray: [(CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0), "Загрузка", "Загрузка")])
    }
}
