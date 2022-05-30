//
//  Home.swift
//  iOS-No_To_Garbage
//
//  Created by Admin on 27.10.2020.
//

import SwiftUI

struct CategoryHome: View {
    @State var showingProfile = false
    @State var showAlert = false
    var profileButton: some View {
        Button(action: { self.showingProfile.toggle() }) {
            Image(systemName: "person.crop.circle")
                .imageScale(.large)
                .accessibility(label: Text("User Profile"))
                .padding()
        }
    }
    var body: some View {
        
        let mainCategory: [String] = ["Кухня","Ванная", "Гардеробная", "Кабинет"]
        NavigationView {
            List {
                NavigationLink( destination: GarbageDetail(garbage: "Батарейки")) {
                    Image("battery")
                        .resizable()
                        .scaledToFill()
                        .frame(height: 200)
                        .clipped()
                        .listRowInsets(EdgeInsets())
                }.padding(.horizontal, -40)
                
                
                
                ForEach(mainCategory, id: \.self) { key in
                    CategoryRow(categoryName: key)
                }
                .listRowInsets(EdgeInsets())
                
                
                CategoryOther()
                    .listRowInsets(EdgeInsets())
                
                
                
                NavigationLink( destination: GarbageList()) {
                    Text("Посмотреть все")
                }
                
                NavigationLink( destination:  AllGarbageMap()) {
                    Text( "Все мусорки города")
                }
                
                NavigationLink( destination: AddImage()) {
                    Text("Добавить фотографию")
                }
                
                NavigationLink( destination: Statistics()) {
                    Text("Статистика")
                }
                NavigationLink( destination: SignIn()) {
                    Text("Войти в личный кабинет")
                }
                
                NavigationLink( destination: AboutApp()) {
                    Text("О приложении")
                }
                
            }
            .navigationBarTitle(Text("Интересное"))
            .navigationBarItems(trailing: profileButton)
            .sheet(isPresented: $showingProfile) {
                ProfileHost()
            }
            
        }
        .padding(.horizontal, -10)
    }
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        CategoryHome()
    }
}

extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }
    
    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}
