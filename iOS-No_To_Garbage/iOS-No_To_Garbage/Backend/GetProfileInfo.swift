//
//  GetProfileInfo.swift
//  iOS-No_To_Garbage
//
//  Created by Admin on 28.10.2020.
//

import Foundation
import FirebaseDatabase

class GetProfileInfo {
    let category:[String] = ["Батарейки", "Бумага", "Техника", "Бутылки", "Одежда в плохом состоянии", "Одежда в хорошем состоянии", "Стеклянные банки", "Контейнеры", "Коробки"]
    func getinfo(uid:String, completion: @escaping (String) -> Void) {
        let rootReference = Database.database().reference()
            let nameReference = rootReference.child("Users").child(uid).child("Name")
            nameReference.observeSingleEvent(of: .value) { (DataSnapshot) in
                let name = DataSnapshot.value as! String
                completion(name)
        }
    }
    
    
    func getGarbage(uid:String, completion: @escaping (String) -> Void) {
        let rootReference = Database.database().reference()
        var garbage = ""
        let garbageReference = rootReference.child("Users").child(uid).child("Garbage")
            for i in 0...self.category.count-1{
                let databaseReference = garbageReference.child(self.category[i])
                databaseReference.observeSingleEvent(of: .value) { (DataSnapshot) in
                    let count = DataSnapshot.value as! String
                    garbage = garbage + "\(self.category[i]): \(count)\n"
                    if (i == self.category.count-1){
                        completion(garbage)
                    }
                }
                
            }
        
    }
    
    
    
    
}
