//
//  AddgarbageToBase.swift
//  iOS-No_To_Garbage
//
//  Created by Admin on 29.11.2020.
//

import Foundation
import Firebase
import FirebaseDatabase

class AddGarbageToBase {
    func add(uid: String, garbage:String, garCount:Int, completion: @escaping (Bool) -> Void) {
        let rootReference = Database.database().reference()
        let garbageReference = rootReference.child("Users").child(uid).child("Garbage").child(garbage)
        
        garbageReference.observeSingleEvent(of: .value) { (DataSnapshot) in
            let kolvoString = DataSnapshot.value as? String ?? "0"
            var count = Int(kolvoString)
            if (count != nil && garCount>0){
                count! += garCount
                garbageReference.setValue(String(count!))
                completion(true)
            }
        }
    }
}
