//
//  GetPhoto.swift
//  iOS-No_To_Garbage
//
//  Created by Admin on 26.01.2021.
//

import Foundation
import FirebaseStorage
class GetPhoto{
    func getPhoto(image:String, completion: @escaping (UIImage) -> Void) {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let i = 0
        
        let imageref = storageRef.child("Garbage").child(image).child("\(i).png")
        
        
        imageref.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print(error)
            } else {
                let image = UIImage(data: data!)
                if image != nil{
                    completion(image!)
                }
            }
        }
    }
}
