//
//  AllGarbageMap.swift
//  iOS-No_To_Garbage
//
//  Created by Admin on 03.01.2021.
//

import SwiftUI
import MapKit
import FirebaseDatabase
struct AllGarbageMap: UIViewRepresentable {
    let garbageInfo = GetGarbageInfo()
    let mapInfo = GetMapInfo()
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        let text = "SELECT * FROM no2garbage_map;"
        GetMapInfo().getMap(path: text) { (resArr) in
            let resArray = resArr
            
            let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
            let region = MKCoordinateRegion(center: resArray[0].0, span: span)
            uiView.setRegion(region, animated: true)
            for i in 0...resArray.count-1{
                let coordinate = resArray[i].0
                let category = resArray[i].1
                let hint = resArray[i].2
                let annotation = MKPointAnnotation()
                annotation.title = category
                annotation.coordinate = coordinate
                annotation.subtitle = hint
                uiView.addAnnotation(annotation)
                
            }
        }
        
        
        
    }
}

struct AllGarbageMap_Previews: PreviewProvider {
    static var previews: some View {
        AllGarbageMap()
    }
}
