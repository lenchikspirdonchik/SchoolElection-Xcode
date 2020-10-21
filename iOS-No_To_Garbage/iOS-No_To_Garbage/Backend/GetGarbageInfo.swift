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
    
    // add completion, remove return type
    func getInfo(path: String, completion: @escaping (String) -> Void) {
        var result = ""
        var realPath = path
        if path == "Бутылки "{
            realPath = "Бутылки"
        }
        
        let rootReference = Database.database().reference()
        let garbageReference = rootReference.child("GarbageInformation").child(realPath).child("body")
        
        garbageReference.observeSingleEvent(of: .value) { (DataSnapshot) in
            result = DataSnapshot.value as? String ?? "0"
            completion(result)
        }   
    }
}
