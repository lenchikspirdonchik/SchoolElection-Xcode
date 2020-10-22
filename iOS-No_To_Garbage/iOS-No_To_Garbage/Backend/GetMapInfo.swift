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
    func getMap(path:String, completion: @escaping ([String : CLLocationCoordinate2D]) -> Void) {
        var realPath = path
        if path == "Бутылки "{
            realPath = "Бутылки"
        }
         var hintArray : [String] = [""]
        var latLangArray: [CLLocationCoordinate2D]
        var  result:[String : CLLocationCoordinate2D] = ["hint 0" : CLLocationCoordinate2D(latitude: 60.013219, longitude: 30.275225)]
        let rootReference = Database.database().reference()
        let garbageReference = rootReference.child("GarbageInformation").child(realPath)
        garbageReference.observeSingleEvent(of: .value) { (DataSnapshot) in
            let trueMapNumber = (DataSnapshot.childrenCount - 2) / 2
            var mapNumber = 0
            
            // while mapNumber < trueMapNumber {
            let geopointReference = garbageReference.child("map\(mapNumber)")
            
            var coordinate = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
            
          
            
            
            geopointReference.observeSingleEvent(of: .value) { (DataSnapshot) in
                let snap = DataSnapshot.value as? String ?? "0"
                let arr = snap.split(separator: ",")
                coordinate = CLLocationCoordinate2D(latitude: Double(arr[0]) ?? 0.00, longitude: Double(arr[1]) ?? 0.00)
                //print(coordinate)
            }
            
            // result[hint] = coordinate
            mapNumber+=1
            // print(result)
            
            // }
            
            
        }
        

            getHint(path: realPath, trueMapNumber: Int(2)) { (resArr) in
                print("hintarr2 \(resArr)")
                hintArray = resArr
            
            print("hintarr\(hintArray)")
        }
   
        print("hintarr0\(hintArray)")
        
        
        
        //return ["hint 0" : CLLocationCoordinate2D(latitude: 60.013219, longitude: 30.275225)]
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
        var mapNumber = 0
        
        for _ in 0...trueMapNumber {
            let hintReference = garbageReference.child("mapHint\(mapNumber)")
            var hint = ""
            hintReference.observeSingleEvent(of: .value) { (DataSnapshot) in
                hint = DataSnapshot.value as? String ?? "0"
                print(hint)
                hintArray.append(hint)
                if hintArray.count == trueMapNumber+1 {
                    print("hintarr3 \(hintArray)")
                    completion (hintArray)
                }
            }
            mapNumber+=1
        }
        
    }
    
    
}
