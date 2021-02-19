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
    @State var category = [""]
    let database = GetProfileInfo()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var showingActionSheet = false
    var body: some View {
        
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
            }
            .onAppear(){
                let text = "select category, SUM(amount) from no2garbage where uuid = '\(user!.uid)' group by category"
                database.getGarbage(text: text) { result in
                    category = result
                }
            }
            
            
            
            Button("Обнулить статистику"){
                let category:[String] = ["Батарейки", "Бумага", "Техника", "Бутылки", "Одежда в плохом состоянии", "Одежда в хорошем состоянии", "Стеклянные банки", "Контейнеры", "Коробки"]
                var text = "DELETE FROM no2garbage\n WHERE  uuid = '\(user!.uid)';"
                AddGarbageToBase().add(text: text) { (isTrue) in
                    self.presentationMode.wrappedValue.dismiss()
                    
                    let date = Date()
                    
                    for i in 0...category.count-1{
                        text = "insert into no2garbage (uuid, date, category, amount)\n VALUES ('\(user!.uid)', date('\(date.get(.month))/\(date.get(.day))/\(date.get(.year))'), '\(category[i])', 1);"
                        
                        AddGarbageToBase().add(text: text) { (isTrue) in
                            print(isTrue)
                        }
                    }
                }
                
            }.padding(.top, 30)
            
            
            
            Button("Удалить аккаунт"){
                self.showingActionSheet = true
            }
            .padding(.top, 30)
            .actionSheet(isPresented: $showingActionSheet) {
                ActionSheet(title: Text("Вы точно хотите удалить аккаунт?"), message: Text("Удалится вся ваша статистика. Это действие будет не отменить!"), buttons: [
                    .destructive(Text("Удалить")) {
                        let text = "DELETE FROM no2garbage\n WHERE  uuid = '\(user!.uid)';"
                        AddGarbageToBase().add(text: text) { (isTrue) in
                            
                            database.delUser(uid: user!.uid)
                            Auth.auth().currentUser?.delete(completion: { (error) in
                                print(error)
                                self.presentationMode.wrappedValue.dismiss()
                                self.presentationMode.wrappedValue.dismiss()
                            })
                        }
                    },
                    .cancel()
                ])
            }
            
            
            
            Button("Выйти") {
                let firebaseAuth = Auth.auth()
                
                do {
                    try firebaseAuth.signOut()
                    self.presentationMode.wrappedValue.dismiss()
                    self.presentationMode.wrappedValue.dismiss()
                    
                } catch let signOutError as NSError {
                    print ("Error signing out: %@", signOutError)                }
            }.padding(.top, 30)
            
            
            
            
            
            Spacer(minLength: 30)
            
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
