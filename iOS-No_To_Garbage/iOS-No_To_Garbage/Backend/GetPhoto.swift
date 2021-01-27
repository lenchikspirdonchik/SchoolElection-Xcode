//
//  GetPhoto.swift
//  iOS-No_To_Garbage
//
//  Created by Admin on 26.01.2021.
//

import Foundation
import FirebaseStorage
class GetPhoto{
    func getPhoto(image:String, completion: @escaping ([UIImage]) -> Void) {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        
        let imageref = storageRef.child("Garbage").child(image)
        imageref.listAll { (result, error) in
            var number = 0
            var imageArray:[UIImage] = []
            print("imageArray.count = \(imageArray.count)")
            for item in result.items {
                item.getData(maxSize: 1 * 1024 * 1024) { data, error in
                    if let error = error {
                        print(error)
                    } else {
                        let image = UIImage(data: data!)
                        if image != nil{
                            imageArray.append(image!)
                            print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA")
                            print("count = \( result.items.count)")
                            print("imageArray.count = \(imageArray.count)")
                            print("number = \(number)")
                            if number ==  result.items.count{
                                completion(imageArray)
                            }
                          
                        }
                        
                    }
                }
                number+=1
            }
            
        }
        
        
    }
}
