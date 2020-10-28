//
//  ProfileHost.swift
//  iOS-No_To_Garbage
//
//  Created by Admin on 27.10.2020.
//

import SwiftUI
import FirebaseAuth
struct ProfileHost: View {
    @State var email = "Загрузка"
    var body: some View {
        Text(email)
            .onAppear(){
                email = Auth.auth().currentUser?.email ?? "Вы еще не вошли. Войдите"
        
            }
        Button("Выйти") {
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
                ProfileHost()
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
        }
    }
    
    
   /* func currUser() -> User {
        let user = Auth.auth().currentUser!
        print(user.email ?? "shit")
        return user
    }*/
}

struct ProfileHost_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHost()
    }
}
