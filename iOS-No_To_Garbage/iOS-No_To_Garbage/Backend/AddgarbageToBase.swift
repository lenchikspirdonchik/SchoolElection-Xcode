//
//  AddgarbageToBase.swift
//  iOS-No_To_Garbage
//
//  Created by Admin on 29.11.2020.
//

import Foundation
import Firebase
import FirebaseDatabase
import PostgresClientKit
class AddGarbageToBase {
    func add(text:String, completion: @escaping (Bool) -> Void) {
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
            completion(true)
            do { cursor.close() }
        } catch {
            print(error)
            completion(false)
        }
        
    }
}
