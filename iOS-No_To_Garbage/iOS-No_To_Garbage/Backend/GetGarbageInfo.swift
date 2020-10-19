//
//  GetGarbageInfo.swift
//  iOS-No_To_Garbage
//
//  Created by Admin on 19.10.2020.
//


import Foundation
import Firebase
import FirebaseDatabase

class GetGarbageInfo {
    var result = ""
    var path = ""
    func getInfo(path:String) -> String{
        let rootReference = Database.database().reference()
        let garbageReference = rootReference.child("GarbageInformation").child(path).child("body")
        
        
        garbageReference.observeSingleEvent(of: .value) { (DataSnapshot) in
            self.result = DataSnapshot.value as? String ?? "0"
            
            
        }
        return result
    }
    
 
    
}
