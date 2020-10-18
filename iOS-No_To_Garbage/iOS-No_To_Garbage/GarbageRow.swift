//
//  GarbageRow.swift
//  iOS-No_To_Garbage
//
//  Created by Admin on 18.10.2020.
//

import SwiftUI

struct GarbageRow: View {
    var garbage:String
    var body: some View {
        let photo:[String : String] = [ "Батарейки" : "battery" , "Бумага" : "paper" , "Техника" : "technic" , "Бутылки" : "kitchenbottles", "Бутылкиkи" : "bathbottles" , "Одежда в плохом состоянии" : "badclothes" , "Одежда в хорошем состоянии" : "goodclothes" , "Стеклянные банки" : "jars" , "Контейнеры" : "containers" , "Коробки" : "box"]
        HStack {
            Image(photo[garbage]!)
                .resizable()
                .frame(width: 50, height: 50)
            Text(garbage)
            Spacer()
            
        }
    }
}

struct GarbageRow_Previews: PreviewProvider {
    static var previews: some View {
        GarbageRow(garbage: "Батарейки")
    }
}
