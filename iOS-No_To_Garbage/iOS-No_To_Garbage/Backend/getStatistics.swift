//
//  getStatistics.swift
//  iOS-No_To_Garbage
//
//  Created by Admin on 22.12.2020.
//

import Foundation
import FirebaseDatabase


class getStatistics {
    let category:[String] = ["Батарейки", "Бумага", "Бутылки", "Стеклянные банки", "Контейнеры", "Коробки"]
    
    func getGarbage(uid:String, completion: @escaping ([(String,Double)]) -> Void) {
        let rootReference = Database.database().reference()
        var points: [(String,Double)] = []
        let garbageReference = rootReference.child("Users").child(uid).child("Garbage")
        
        for i in 0...self.category.count-1{
            let databaseReference = garbageReference.child(self.category[i])
            databaseReference.observeSingleEvent(of: .value) { (DataSnapshot) in
                let count = DataSnapshot.value as! String
                points.append((self.category[i],  Double(count) ?? 0.0))
                if (points.count == self.category.count){
                    completion(points)
                }
            }
            
        }
    }
}

