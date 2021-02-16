//
//  AddGarbageMap.swift
//  iOS-No_To_Garbage
//
//  Created by Admin on 09.01.2021.
//

import SwiftUI
import MapKit

struct AddGarbageMap: UIViewRepresentable {
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
    
    }
    
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
       
        return mapView
    }
}




struct AddGarbageMap_Previews: PreviewProvider {
    static var previews: some View {
        AddGarbageMap()
    }
}


