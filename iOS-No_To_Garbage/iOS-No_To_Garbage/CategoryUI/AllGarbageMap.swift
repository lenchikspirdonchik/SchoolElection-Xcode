//
//  AllGarbageMap.swift
//  iOS-No_To_Garbage
//
//  Created by Admin on 03.01.2021.
//

import SwiftUI
import MapKit
struct AllGarbageMap: UIViewRepresentable {
    let garbageInfo = GetGarbageInfo()
    let mapInfo = GetMapInfo()
    let category:[String] = ["Батарейки", "Бумага", "Техника", "Бутылки", "Одежда в плохом состоянии", "Одежда в хорошем состоянии", "Стеклянные банки", "Контейнеры", "Коробки"]
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0), span: span)
        uiView.setRegion(region, animated: true)
        
        
        
        for i in 0...category.count-1 {
            var coordinate = [CLLocationCoordinate2D(latitude: 0.00, longitude: 0.00)]
             var hint = ["загрузка"]
            mapInfo.getNumber(path: category[i]) { (number) in
                mapInfo.getHint(path: category[i], trueMapNumber: number) { (resArr) in
                    hint = resArr
                }
                mapInfo.getMap(path: category[i], trueMapNumber: number) { (pointArr) in
                    coordinate = pointArr
                }
                print(hint)
                print(coordinate)
            }
 
        
            
            for i in 0...coordinate.count-1{
               // print(coordinate.count)
                //print(hint)
                //print(coordinate)
                let annotation = MKPointAnnotation()
                annotation.title = hint[i]
                annotation.subtitle = hint[i]
                annotation.coordinate = coordinate[i]
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
