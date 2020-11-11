//
//  SignUp.swift
//  iOS-No_To_Garbage
//
//  Created by Admin on 10.11.2020.
//

import SwiftUI
import Firebase
struct SignUp: View {
    @State private var email = ""
    @State private var password = ""
    @State private var passwordRepeat = ""
    @State private var name = ""
    var body: some View {
        let action: () ->Void = {
            if password == passwordRepeat {
                if name != "" {
                    CreatUser().sign(email: email, password: password, name: name)
                }
            }
            else{
                Alert(title: Text("Ошибка!"), message: Text("Ваши пароли не совпали"),primaryButton: .default(Text ("ОК")), secondaryButton:  .default(Text("Попробуем еще раз")))
            }
            
        }
        
        ScrollView {
            Text("Зарегистрируйтесь, чтобы получить доступ ко многим полезным вещам")
                .padding(.bottom, 60)
            
            
            HStack {
                Image("person.circle.fill")
                    .imageScale(.large)
                    .padding(.leading)
                
                TextField("Введите почту", text: $email)
                    .padding(.vertical)
                    .accentColor(.orange)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
            }
            .background(
                RoundedRectangle(cornerRadius: 16.0, style: .circular)
                    .foregroundColor(Color(.secondarySystemFill)))
            
            
            HStack {
                Image("person.circle.fill")
                    .imageScale(.large)
                    .padding(.leading)
                
                TextField("Введите имя", text: $name)
                    .padding(.vertical)
                    .accentColor(.orange)
                    .autocapitalization(.words)
                    .keyboardType(.default)
                    .textContentType(.name)
            }
            .background(
                RoundedRectangle(cornerRadius: 16.0, style: .circular)
                    .foregroundColor(Color(.secondarySystemFill)))
            
            
            HStack {
                Image("person.circle.fill")
                    .imageScale(.large)
                    .padding(.leading)
                
                TextField("Введите пароль", text: $password)
                    .padding(.vertical)
                    .accentColor(.orange)
                    .autocapitalization(.none)
                    .keyboardType(.default)
                    .textContentType(.password)
            }
            .background(
                RoundedRectangle(cornerRadius: 16.0, style: .circular)
                    .foregroundColor(Color(.secondarySystemFill)))
            
            
            
            
            HStack {
                Image("person.circle.fill")
                    .imageScale(.large)
                    .padding(.leading)
                
                TextField("Повторите пароль", text: $passwordRepeat)
                    .padding(.vertical)
                    .accentColor(.orange)
                    .autocapitalization(.none)
                    .keyboardType(.default)
                    .textContentType(.password)
            }
            .background(
                RoundedRectangle(cornerRadius: 16.0, style: .circular)
                    .foregroundColor(Color(.secondarySystemFill)))
            
            
            
            Button(action: action) {
                HStack {
                    Spacer()
                    Text("Зарегистрироваться")
                        .padding()
                        .accentColor(.white)
                    Spacer()
                }
            }
            .background(Color.blue)
            .cornerRadius(16.0)
            
            
            
            Spacer()
        }
        .padding()
        .navigationBarTitle("Регистрация")
    }
}


struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}


class CreatUser{
    let category:[String] = ["Батарейки", "Бумага", "Техника", "Бутылки", "Бутылки ", "Одежда в плохом состоянии", "Одежда в хорошем состоянии", "Стеклянные банки", "Контейнеры", "Коробки"]
    func sign(email:String, password:String, name:String) {
        print("in func sign up")
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if (user != nil){
                Auth.auth().currentUser?.sendEmailVerification { (error) in }
                self.createGarbageInDatabase(user: user!)
                //self.saveNameInDatabase(user: user!, name: name)
                let rootReference = Database.database().reference()
                let nameReference = rootReference.child("Users").child((user?.user.uid)!).child("Name")
                nameReference.setValue(name)
            }
        }
        
    }
    
    
    func createGarbageInDatabase(user:AuthDataResult){
        let rootReference = Database.database().reference()
        let garbageReference = rootReference.child("Users").child(user.user.uid).child("Garbage")
        for i in 0...category.count-1{
            let databaseReference = garbageReference.child(category[i])
            databaseReference.setValue("0")
        }
    }
    
    func saveNameInDatabase(user: AuthDataResult, name:String) {
        let rootReference = Database.database().reference()
        let nameReference = rootReference.child("Users").child(user.user.uid).child("Name")
        nameReference.setValue(name)
    }
    
    
}
