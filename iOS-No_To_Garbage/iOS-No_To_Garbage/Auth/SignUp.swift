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
    @State var showAlert = false
    @State var showGoodAlert = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
       
        
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
                Image("person.circle")
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
                Image("person.circle")
                    .imageScale(.large)
                    .padding(.leading)
                
                TextField("Введите пароль (от 5 символов)", text: $password)
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
            
            
            
            Button(action: {
                if password == passwordRepeat {
                    if password.count > 5 && !name.isEmpty{
                        CreatUser().sign(email: email, password: password, name: name){ (istrue) in
                            if istrue{
                                showGoodAlert = true
                            } else{
                                showGoodAlert = false
                            }
                            self.showAlert.toggle()
                        }
                    }
                    else{
                        showGoodAlert = false
                    
                    self.showAlert.toggle()
                    }
                }
            }) {
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
            .alert(isPresented: $showAlert) { () -> Alert in
                
                if (showGoodAlert){
                    let button = Alert.Button.default(Text("OK")) {
                        print("Вы успешно зарегистрировались!")
                        self.presentationMode.wrappedValue.dismiss()
                        self.presentationMode.wrappedValue.dismiss()
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    return Alert(title: Text("Поздравляем!"), message: Text("Вы успешно зарегистрировались!"), dismissButton: button)
                }else{
                    
                    let primaryButton = Alert.Button.cancel(Text("Конечно!")) {
                        print("primary button pressed")
                        email = ""
                        password = ""
                        passwordRepeat = ""
                        name = ""
                        
                    }
                    let secondaryButton = Alert.Button.destructive(Text("в следующий раз")) {
                        print("secondary button pressed")
                        self.presentationMode.wrappedValue.dismiss()
                        self.presentationMode.wrappedValue.dismiss()
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    return Alert(title: Text("Произошла ошибка("), message: Text("Повторим еще раз?"), primaryButton: primaryButton, secondaryButton: secondaryButton)
                }
            }
            
            
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
    let category:[String] = ["Батарейки", "Бумага", "Техника", "Бутылки", "Одежда в плохом состоянии", "Одежда в хорошем состоянии", "Стеклянные банки", "Контейнеры", "Коробки"]
    func sign(email:String, password:String, name:String, completion: @escaping (Bool) -> Void) {
        print("in func sign up")
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            print("error = \(error.debugDescription)")
            if (user != nil){
                Auth.auth().currentUser?.sendEmailVerification { (error) in }
               self.createGarbageInDatabase()
                self.saveNameInDatabase(name: name)
                completion(true)
            }
            else {
                print("error = \(error.debugDescription)")
                completion(false)
            }
        }
        
    }
    
    
    func createGarbageInDatabase(){
        print("in createGarbageInDatabase")
        let rootReference = Database.database().reference()
        let user2 = Auth.auth().currentUser
        let garbageReference = rootReference.child("Users").child(user2!.uid).child("Garbage")
        for i in 0...category.count-1{
            print("in for createGarbageInDatabase. i = \(i)")
            let databaseReference = garbageReference.child(category[i])
            databaseReference.setValue("0")
        }
    }
    
    func saveNameInDatabase(name:String) {
        print("in saveNameInDatabase")
        let rootReference = Database.database().reference()
        let user2 = Auth.auth().currentUser
        let nameReference = rootReference.child("Users").child(user2!.uid).child("Name")
        nameReference.setValue(name)
    }
    
    
}
