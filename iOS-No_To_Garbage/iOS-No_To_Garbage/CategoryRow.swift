//
//  CategoryRow.swift
//  iOS-No_To_Garbage
//
//  Created by Admin on 27.10.2020.
//

import SwiftUI

struct CategoryRow: View {
    var categoryName: String
    
    
    func setCategory(mainCategory:String) -> [String] {
        var category: [String] = [""]
        switch mainCategory {
        case "Кухня": category = ["Стеклянные банки", "Бутылки", "Контейнеры", "Коробки"]
        case "Ванная":category = ["Бутылки "]
        case "Гардеробная":category = ["Одежда в плохом состоянии", "Одежда в хорошем состоянии"]
        case "Кабинет": category = ["Батарейки", "Бумага", "Техника"]
        default: category = ["Батарейки", "Бумага", "Техника"]
        }
        return category
    }
    
    var body: some View {
        
        let category = setCategory(mainCategory: categoryName)
        
        VStack(alignment: .leading) {
            Text(categoryName)
                .font(.headline)
                .padding(.leading, 15)
                .padding(.top, 5)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
                    ForEach(category, id: \.self) { garbage in
                        NavigationLink(
                            destination: GarbageDetail(garbage: garbage)
                        ) {
                            CategoryItem(garbage: garbage)
                        }
                    }
                }
            }
            .frame(height: 185)
        }
    }
}


struct CategoryItem: View {
    var garbage:String
    var body: some View {
        
        let photo:[String : String] = [ "Батарейки" : "battery" , "Бумага" : "paper" , "Техника" : "technic" , "Бутылки" : "kitchenbottles", "Бутылки " : "bathbottles" , "Одежда в плохом состоянии" : "badclothes" , "Одежда в хорошем состоянии" : "goodclothes" , "Стеклянные банки" : "jars" , "Контейнеры" : "containers" , "Коробки" : "box"]

        VStack(alignment: .leading) {
            Image(photo[garbage]!)
                .renderingMode(.original)
                .resizable()
                .frame(width: 155, height: 155)
                .cornerRadius(5)
            Text(garbage)
                .foregroundColor(.primary)
                .font(.caption)
        }
        .padding(.leading, 15)
    }
}




struct CategoryRow_Previews: PreviewProvider {
    static var previews: some View {
        CategoryRow(categoryName: "Кабинет")
    }
}
