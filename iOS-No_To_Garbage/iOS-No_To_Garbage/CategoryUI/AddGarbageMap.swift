//
//  AddGarbageMap.swift
//  iOS-No_To_Garbage
//
//  Created by Admin on 09.01.2021.
//

import SwiftUI
import MapKit
struct AddGarbageMap: UIViewRepresentable {
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
        let annotation = MKPointAnnotation()
        annotation.title = "Title"
        annotation.subtitle = "Hint"
        annotation.coordinate = CLLocationCoordinate2D(latitude: 60.0108, longitude: 30.2802)
        uiView.addAnnotation(annotation)
    }
    
    
    
    
}

struct AddGarbageMap_Previews: PreviewProvider {
    static var previews: some View {
        AddGarbageMap()
    }
}
