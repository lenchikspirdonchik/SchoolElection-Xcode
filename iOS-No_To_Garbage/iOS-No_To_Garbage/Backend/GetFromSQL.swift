//
//  GetFromSQL.swift
//  iOS-No_To_Garbage
//
//  Created by Admin on 16.02.2021.
//

import Foundation
import PostgresClientKit
class GetFromSQL {
    func getSQLStatistics(text:String, completion: @escaping ([String]) -> Void) {
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
                let date = try columns[2].date()
                let category = try columns[3].string()
                let amount = try columns[4].string()
                let res = "\(date): \(category) = \(amount)"
                print(res)
                result.append(res)
            }
            statement.close()
            completion(result)
        } catch {
            print(error) // better error handling goes here
        }
    }
    
    
}
