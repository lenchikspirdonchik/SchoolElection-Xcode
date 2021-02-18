    //
    //  GetMapInfo.swift
    //  iOS-No_To_Garbage
    //
    //  Created by Admin on 19.10.2020.
    //
    import Foundation
    import MapKit
    import PostgresClientKit
    class GetMapInfo {
        func getMap(path:String, completion: @escaping ([(CLLocationCoordinate2D, String, String)]) -> Void) {
            
            var resArray: [(CLLocationCoordinate2D, String, String)] = []
            do {
                var configuration = PostgresClientKit.ConnectionConfiguration()
                configuration.host = "ec2-108-128-104-50.eu-west-1.compute.amazonaws.com"
                configuration.database = "dvvl3t4j8k5q7"
                configuration.user = "mpzdfkfaoiwywz"
                configuration.credential = .md5Password(password: "c37ce7e3b99d480a04b8943b89ba6e7abb94cb86c56bfa4c6ace4fab4cbc287d")
                
                let connection = try PostgresClientKit.Connection(configuration: configuration)
                defer { connection.close() }
                let statement = try connection.prepareStatement(text: path)
                defer { statement.close() }
                
                let cursor = try statement.execute()
                defer { cursor.close() }
                for row in cursor {
                    let columns = try row.get().columns
                    // let whoadd:String? = try columns[1].string()
                    let category = try columns[2].string()
                    let latlang = try columns[3].string()
                    let splitPoint = latlang.split(separator: ",")
                    let coordinate = CLLocationCoordinate2D(latitude: Double(splitPoint[0]) ?? 0.00, longitude: Double(splitPoint[1]) ?? 0.00)
                    let hint = try columns[4].string()
                    resArray.append((coordinate, category, hint))
                }
                statement.close()
                completion(resArray)
            } catch {
                print(error)
            }
        }
        
    }
