//
//  GarbageList.swift
//  iOS-No_To_Garbage
//
//  Created by Admin on 19.10.2020.
//

import SwiftUI

struct GarbageList: View {
    var body: some View {
        let photo:[String] = ["Батарейки", "Бумага", "Техника", "Бутылки", "Бутылки ", "Одежда в плохом состоянии", "Одежда в хорошем состоянии", "Стеклянные банки", "Контейнеры", "Коробки"]
    
        NavigationView{
            List{
                ForEach(photo, id: \.self) { index in
                    NavigationLink(
                        destination: GarbageDetail(garbage: index)
                    ) {
                        GarbageRow(garbage: index)
                    }
                    
                }
            
           
            }.navigationBarTitle(Text("Мусор"))
        }
        
    }
}

struct GarbageList_Previews: PreviewProvider {
    static var previews: some View {
        GarbageList()
    }
}
