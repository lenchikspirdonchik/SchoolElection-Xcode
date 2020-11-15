//
//  SignIn.swift
//  iOS-No_To_Garbage
//
//  Created by Admin on 28.10.2020.
//

import SwiftUI
import Firebase
struct SignIn: View {
    @State private var email = ""
    @State private var password = ""
    @State private var hoho = ""
    @State var showAlert = false
    @State var showGoodAlert = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        
        
        ScrollView {
            Text("Войдите в личный кабинет, чтобы получить доступ ко многим полезным вещам")
            
            
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
            
            
            
            VStack{
                
                Button(action: {
                    Sign().sign(email: email, password: password) { (istrue) in
                        if istrue{
                            showGoodAlert = true
                        } else{
                            showGoodAlert = false
                        }
                        self.showAlert.toggle()
                    }
                }) {
                    HStack {
                        Spacer()
                        Text("Войти")
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
                            print("Вы успешно вошли!")
                            self.presentationMode.wrappedValue.dismiss()
                        }
                        return Alert(title: Text("Поздравляем!"), message: Text("Вы успешно вошли!"), dismissButton: button)
                    }else{
                        
                        let primaryButton = Alert.Button.cancel(Text("Конечно!")) {
                            print("primary button pressed")
                            
                        }
                        let secondaryButton = Alert.Button.destructive(Text("в следующий раз")) {
                            print("secondary button pressed")
                            self.presentationMode.wrappedValue.dismiss()
                        }
                        return Alert(title: Text("Произошла ошибка("), message: Text("Повторим еще раз?"), primaryButton: primaryButton, secondaryButton: secondaryButton)
                    }
                }
            }
            
            
            
            NavigationLink(
                destination: SignUp(),
                label: {
                    Text("Еще нет аккаунта? Зарегистрируйтесь")
                }).foregroundColor(.gray)
            
            
            Spacer()
        }
        .padding()
        .navigationBarTitle("Вход")
        
        
    }
    
}




struct SignIn_Previews: PreviewProvider {
    static var previews: some View {
        SignIn()
    }
}


class Sign{
    func sign(email:String, password:String, completion: @escaping (Bool) -> Void){
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if user?.user.uid != nil{
                completion(true)
            }
            else{
                completion(false)
            }
        }
        
        
    }
    
    func currUser() -> User {
        let user = Auth.auth().currentUser!
        print(user.email ?? "shit")
        return user
    }
}
