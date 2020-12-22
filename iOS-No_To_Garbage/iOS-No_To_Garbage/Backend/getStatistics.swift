//
//  getStatistics.swift
//  iOS-No_To_Garbage
//
//  Created by Admin on 22.12.2020.
//

import Foundation
import FirebaseDatabase


class getStatistics {
    let category:[String] = ["Батарейки", "Бумага", "Техника", "Бутылки", "Одежда в плохом состоянии", "Одежда в хорошем состоянии", "Стеклянные банки", "Контейнеры", "Коробки"]
    func getGarbage(uid:String, completion: @escaping ([Int]) -> Void) {
        let rootReference = Database.database().reference()
        var garbage = [0]
        let garbageReference = rootReference.child("Users").child(uid).child("Garbage")
        for i in 0...self.category.count-1{
            let databaseReference = garbageReference.child(self.category[i])
            databaseReference.observeSingleEvent(of: .value) { (DataSnapshot) in
                let count = DataSnapshot.value as! String
                garbage.append(Int(count) ?? 0)
                if (garbage.count == self.category.count){
                completion(garbage)
                }
            }
            
        }
    }
}
    
