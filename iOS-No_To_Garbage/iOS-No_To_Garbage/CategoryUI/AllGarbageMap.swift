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
    let category:[String] = ["Батарейки", "Бумага", "Техника", "Бутылки", "Одежда в плохом состоянии", "Одежда в хорошем состоянии", "Стеклянные банки", "Контейнеры", "Коробки"]
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 60.0040, longitude: 30.2696), span: span)
        uiView.setRegion(region, animated: true)
        

        for i in 0...category.count-1 {
             
            mapInfo.getNumber(path: category[i]) { (number) in
                let realPath = category[i]
                var latLangArray = CLLocationCoordinate2D(latitude: 0.00, longitude: 0.00)
                var hintArray = ""
                let rootReference = Database.database().reference()
                let garbageReference = rootReference.child("GarbageInformation").child(realPath)
                var mapNumber = 0
                while (mapNumber < number){
                    let hintReference = garbageReference.child("mapHint\(mapNumber)")
                    let mapReference = garbageReference.child("map\(mapNumber)")
                    hintReference.observeSingleEvent(of: .value) { (DataSnapshot) in
                        hintArray = DataSnapshot.value as? String ?? "0"
                    }
                    
                    
                    mapReference.observeSingleEvent(of: .value) { (Snapshot) in
                        let point = Snapshot.value as? String ?? "0.00,0.00"
                        let splitPoint = point.split(separator: ",")
                        latLangArray = CLLocationCoordinate2D(latitude: Double(splitPoint[0]) ?? 0.00, longitude: Double(splitPoint[1]) ?? 0.00)

                        let annotation = MKPointAnnotation()
                        annotation.title = category[i]
                        annotation.subtitle = hintArray
                        annotation.coordinate = latLangArray
                        uiView.addAnnotation(annotation)
                        
                    }
                    mapNumber+=1
                }
                
            }
        }
        
        
    }
}

struct AllGarbageMap_Previews: PreviewProvider {
    static var previews: some View {
        AllGarbageMap()
    }
}
