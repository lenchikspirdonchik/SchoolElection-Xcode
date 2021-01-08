 //
 //  AboutApp.swift
 //  iOS-No_To_Garbage
 //
 //  Created by Admin on 08.01.2021.
 //
 
 import SwiftUI
 
 struct AboutApp: View {
    var body: some View {
        VStack(){
            Image("logo")
                .resizable()
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 8)
                .frame(width: 200, height: 200)
                .padding(.top, -40)
            
            Text("Скажи мусору да!").bold()
            Text("Version 1.0").foregroundColor(.gray)
            
            
            VStack(){
                Text("Благодарим движение \"Раздельный мусор\" за подробный справочник материалов для переработки, который был частично использован нами при работе над приложением.")
                
                if #available(iOS 14.0, *) {
                    Link("https://rsbor-msk.ru", destination: URL(string: "https://rsbor-msk.ru")!)
                }else{
                    Text("https://rsbor-msk.ru")
                }
            }
            .padding(.horizontal)
            
            Spacer()
            
            VStack(){
            Text("Связаться с разработчиком:")
            
            if #available(iOS 14.0, *) {
                Link("VK: https://vk.com/leonid.spiri", destination: URL(string: "https://vk.com/leonid.spiri")!).foregroundColor(.gray)
                Link("in: https://www.linkedin.com/...", destination: URL(string: "https://www.linkedin.com/in/leonid-spiridonov-424a601ab/")!).foregroundColor(.gray)
                Link("Gmail: spiridonov.production@gmail.com", destination: URL(string: "spiridonov.production@gmail.com")!).foregroundColor(.gray)
                
            } else {
                Text("VK: https://vk.com/leonid.spiri").foregroundColor(.gray)
                Text("in: https://www.linkedin.com/...").foregroundColor(.gray)
                Text("Gmail: spiridonov.production@gmail.com").foregroundColor(.gray)
                
            }
            }.padding(.horizontal)
            
            
            
            Spacer()
        }
        
        
    }
 }
 
 
 struct AboutApp_Previews: PreviewProvider {
    static var previews: some View {
        AboutApp()
    }
 }
