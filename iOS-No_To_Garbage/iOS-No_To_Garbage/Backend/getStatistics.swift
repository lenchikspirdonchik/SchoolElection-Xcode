//
//  getStatistics.swift
//  iOS-No_To_Garbage
//
//  Created by Admin on 22.12.2020.
//

import Foundation
import PostgresClientKit


class getStatistics {
  
    func getGarbage(uid:String, completion: @escaping ([(String,Double)]) -> Void) {

        var points: [(String,Double)] = []
        do {
            var configuration = PostgresClientKit.ConnectionConfiguration()
            configuration.host = "ec2-108-128-104-50.eu-west-1.compute.amazonaws.com"
            configuration.database = "dvvl3t4j8k5q7"
            configuration.user = "mpzdfkfaoiwywz"
            configuration.credential = .md5Password(password: "c37ce7e3b99d480a04b8943b89ba6e7abb94cb86c56bfa4c6ace4fab4cbc287d")
            
            let connection = try PostgresClientKit.Connection(configuration: configuration)
            defer { connection.close() }
            
            let text = "select category, SUM(amount) from no2garbage where uuid = '\(uid)' group by category"
            let statement = try connection.prepareStatement(text: text)
            defer { statement.close() }
            
            let cursor = try statement.execute()
            defer { cursor.close() }
            
            for row in cursor {
                let columns = try row.get().columns
                let category = try columns[0].string()
                let amount = try columns[1].string()

                points.append((category, Double(amount) ?? 0.0))
            }
            statement.close()
            completion(points)
        } catch {
            print(error)
        }
        
    }
    
}

