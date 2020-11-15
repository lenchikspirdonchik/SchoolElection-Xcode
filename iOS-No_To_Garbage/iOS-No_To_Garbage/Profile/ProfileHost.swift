//
//  ProfileHost.swift
//  iOS-No_To_Garbage
//
//  Created by Admin on 27.10.2020.
//

import SwiftUI
import FirebaseAuth
struct ProfileHost: View {
    @State var name = "Загрузка"
    @State var txtEmail = "Загрузка"
    @State var garbage = ""
    let database = GetProfileInfo()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        var category = [""]
        let user = currUser()
        if (user != nil){
            
            
            Text(name).onAppear(){
                database.getinfo(uid: user!.uid) { result in
                    name = "Добрый день, \(result)."
                }
            }.padding(.all, 20)
            
            

            List{
                
                Text(txtEmail).onAppear(){
                    let email = user?.email
                    txtEmail = "Почта: \(email ?? "")"
                }
                
                ForEach(category, id: \.self) { key in
                    Text(key)
                }
            }.onAppear(){
                database.getGarbage(uid: user!.uid) { result in
                    category = result
                    print(category)
                }
            }
            
            Button("Выйти") {
                let firebaseAuth = Auth.auth()
                do {
                    try firebaseAuth.signOut()
                    self.presentationMode.wrappedValue.dismiss()
                    
                } catch let signOutError as NSError {
                    print ("Error signing out: %@", signOutError)
                    self.presentationMode.wrappedValue.dismiss()
                }
            }.padding(.top, 30)
            
        }
        
        
        
        else{
            Text("Вы еще не вошли")
            NavigationView{
                
                NavigationLink(
                    destination: SignIn(),
                    label: {
                        Text("Войти")
                    })
            }
        }
        
    }
    
    
    func currUser() -> User? {
        let user = Auth.auth().currentUser
        return user
    }
}

struct ProfileHost_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHost()
    }
}
