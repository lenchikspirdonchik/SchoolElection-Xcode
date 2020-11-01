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
    
    
    var body: some View {
        
        
        ScrollView {
            Text("Войдите в личный кабинет, чтобы получить доступ ко многим полезным вещам")
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
            
            
      
            CustomStyledButton(title: "Войти", action: {
                
                Sign().sign(email: email, password: password)
                Alert(title: Text("Вход в личный кабинет"), message: Text("Вы успешно вошли!"),primaryButton: .default(Text ("Ура")), secondaryButton:  .default(Text("Попробуем еще раз")))
                
               
                
            })
            .disabled(email.isEmpty)
            .padding(.top, 16)
            
            
            
            
                            VStack {
                    NavigationLink(destination: GarbageList()) {
                        Text("Еще нет аккаунта? Зарегистрируйтесь!")
                            .frame(alignment: .center)
                            .foregroundColor(Color.gray)
                    }
                }

            
            
            
            Spacer()
        }
        .padding()
        .navigationBarTitle("Вход")
    }
}




struct CustomStyledButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Spacer()
                Text(title)
                    .padding()
                    .accentColor(.white)
                Spacer()
            }
        }
        .background(Color.blue)
        .cornerRadius(16.0)
    }
}



struct CustomStyledTextField: View {
    @Binding var text: String
    let placeholder: String
    let symbolName: String
    
    var body: some View {
        HStack {
            Image(systemName: symbolName)
                .imageScale(.large)
                .padding(.leading)
            
            TextField(placeholder, text: $text)
                .padding(.vertical)
                .accentColor(.orange)
                .autocapitalization(.none)
        }
        .background(
            RoundedRectangle(cornerRadius: 16.0, style: .circular)
                .foregroundColor(Color(.secondarySystemFill))
        )
    }
}



struct SignIn_Previews: PreviewProvider {
    static var previews: some View {
        SignIn()
    }
}


class Sign{
    func sign(email:String, password:String) -> Bool {
        print("in func sign in")
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else {
                print(authResult?.user.uid ?? "shit")
                return }
            
        }
        
        return false
    }
    
    func currUser() -> User {
        let user = Auth.auth().currentUser!
        print(user.email ?? "shit")
        return user
    }
}
