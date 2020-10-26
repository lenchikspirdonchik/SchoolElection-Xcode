    //
    //  GetMapInfo.swift
    //  iOS-No_To_Garbage
    //
    //  Created by Admin on 19.10.2020.
    //
    import Foundation
    import FirebaseDatabase
    import MapKit
    
    class GetMapInfo {
        func getMap(path:String, trueMapNumber: Int, completion: @escaping ([CLLocationCoordinate2D]) -> Void) {
            
            var realPath = path
            if path == "Бутылки "{
                realPath = "Бутылки"
            }
            var latLangArray: [CLLocationCoordinate2D] = [CLLocationCoordinate2D(latitude: 0.00, longitude: 0.00)]
            let rootReference = Database.database().reference()
            for mapNumber in 0...trueMapNumber {
            let garbageReference = rootReference.child("GarbageInformation").child(realPath).child("map\(mapNumber)")
                garbageReference.observeSingleEvent(of: .value) { (DataSnapshot) in
                    let point = DataSnapshot.value as? String ?? "0.00,0.00"
                    let splitPoint = point.split(separator: ",")
                    let coordinate = CLLocationCoordinate2D(latitude: Double(splitPoint[0]) ?? 0.00, longitude: Double(splitPoint[1]) ?? 0.00)
                    latLangArray.append(coordinate)
                    if latLangArray.count-1 == trueMapNumber {
                        completion (latLangArray)
                    }
                }
                
            }
            
            
            
        }
        
        func getNumber(path: String, completion: @escaping (Int) -> Void) {
            var realPath = path
            if path == "Бутылки "{
                realPath = "Бутылки"
            }
            let rootReference = Database.database().reference()
            let garbageReference = rootReference.child("GarbageInformation").child(realPath)
            garbageReference.observeSingleEvent(of: .value) { (DataSnapshot) in
                let trueMapNumber = (DataSnapshot.childrenCount - 2) / 2
                completion (Int (trueMapNumber))
            }
            
        }
        
        
        
        
        
        func getHint(path: String, trueMapNumber: Int, completion: @escaping ([String]) -> Void) {
            var realPath = path
            if path == "Бутылки "{
                realPath = "Бутылки"
            }
            var hintArray : [String] = [""]
            let rootReference = Database.database().reference()
            let garbageReference = rootReference.child("GarbageInformation").child(realPath)
            
            for mapNumber in 0...trueMapNumber {
                let hintReference = garbageReference.child("mapHint\(mapNumber)")
                var hint = ""
                hintReference.observeSingleEvent(of: .value) { (DataSnapshot) in
                    hint = DataSnapshot.value as? String ?? "0"
                    hintArray.append(hint)
                    if hintArray.count-1 == trueMapNumber {
                        completion (hintArray)
                    }
                }
            
            }
            
        }
        
        
    }
