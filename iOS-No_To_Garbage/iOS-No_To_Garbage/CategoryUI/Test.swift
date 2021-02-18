//
//  Test.swift
//  iOS-No_To_Garbage
//
//  Created by Ольга Завьялова on 23.01.2021.
//

import SwiftUI
import FirebaseAuth
struct Test: View {
    @State var result:[String]=[]
    var body: some View {
        
        
        
        List{
            Text("text")
            ForEach(result, id: \.self) { key in
                
                Text(key)
            }
        }.onAppear{
            let user = currUser()
            if (user != nil){
                GetFromSQL().getFromSQL(uuid: user!.uid, category: "Бутылки") { (res) in
                    result = res
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
