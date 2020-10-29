//
//  GetProfileInfo.swift
//  iOS-No_To_Garbage
//
//  Created by Admin on 28.10.2020.
//

import Foundation
import FirebaseDatabase

class GetProfileInfo {
    
    func getinfo(uid:String, completion: @escaping (String) -> Void) {
        let rootReference = Database.database().reference()
            let nameReference = rootReference.child("Users").child(uid).child("Name")
            nameReference.observeSingleEvent(of: .value) { (DataSnapshot) in
                let name = DataSnapshot.value as! String
                completion(name)
        }
    }
    
    
    
    
}
