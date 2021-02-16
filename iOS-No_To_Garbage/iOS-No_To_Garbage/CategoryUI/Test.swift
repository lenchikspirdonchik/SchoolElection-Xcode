//
//  Test.swift
//  iOS-No_To_Garbage
//
//  Created by Ольга Завьялова on 23.01.2021.
//

import SwiftUI
import FirebaseAuth
struct Test: View {
   @State var text = "Загрузка"
    var body: some View {
        
        
        
       Text(text)
        .onAppear{
            let user = currUser()
            if (user != nil){
                GetFromSQL().getFromSQL(uuid: user!.uid, category: "Батарейки") { (result) in
                    text = result
                }
            }
        }
    }
}
func currUser() -> User? {
    let user = Auth.auth().currentUser
    return user
}

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
    }
}
