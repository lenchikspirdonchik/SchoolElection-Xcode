//
//  GetProfileInfo.swift
//  iOS-No_To_Garbage
//
//  Created by Admin on 28.10.2020.
//

import Foundation
import FirebaseDatabase
import PostgresClientKit
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
    
    
    func getGarbage(text:String, completion: @escaping ([String]) -> Void) {
        var result: [String] = []
        do {
            var configuration = PostgresClientKit.ConnectionConfiguration()
            configuration.host = "ec2-108-128-104-50.eu-west-1.compute.amazonaws.com"
            configuration.database = "dvvl3t4j8k5q7"
            configuration.user = "mpzdfkfaoiwywz"
            configuration.credential = .md5Password(password: "c37ce7e3b99d480a04b8943b89ba6e7abb94cb86c56bfa4c6ace4fab4cbc287d")
            
            let connection = try PostgresClientKit.Connection(configuration: configuration)
            defer { connection.close() }
            let statement = try connection.prepareStatement(text: text)
            defer { statement.close() }
            
            let cursor = try statement.execute()
            defer { cursor.close() }
            
            for row in cursor {
                let columns = try row.get().columns
                let category = try columns[0].string()
                let amount = try columns[1].string()
                let res = "\(category): \(amount)"
                print(res)
                result.append(res)
            }
            statement.close()
            completion(result)
        } catch {
            print(error) // better error handling goes here
        }
    }
    
    
    
  
    
    func delUser(uid:String) {
        let rootReference = Database.database().reference()
        let userReference = rootReference.child("Users").child(uid)
        userReference.removeValue()
    }
    
}
