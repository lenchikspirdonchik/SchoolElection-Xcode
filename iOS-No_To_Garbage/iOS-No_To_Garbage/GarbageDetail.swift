//
//  GarbageDetail.swift
//  iOS-No_To_Garbage
//
//  Created by Admin on 18.10.2020.
//

import SwiftUI
import MapKit
struct GarbageDetail: View {

    let garbage:String
    var body: some View {
        let coordinate = [CLLocationCoordinate2D(latitude: 60.013219, longitude: 30.275225)]
        let hint = ["hint 0"]
        let photo:[String : String] = [ "Батарейки" : "battery" , "Бумага" : "paper" , "Техника" : "technic" , "Бутылки" : "kitchenbottles", "Бутылкиkи" : "bathbottles" , "Одежда в плохом состоянии" : "badclothes" , "Одежда в хорошем состоянии" : "goodclothes" , "Стеклянные банки" : "jars" , "Контейнеры" : "containers" , "Коробки" : "box"]
        ScrollView(.vertical, showsIndicators: false)  {
            MapView(coordinate: coordinate, hint: hint)
                .edgesIgnoringSafeArea(.top)
                .frame(height: 450)
            
            CircleImage(image: Image(photo[garbage]!))
                .offset(x: 0, y: -80)
                .padding(.bottom, -130)
            
            VStack(alignment: .leading) {
                HStack {
                    Text(garbage)
                        .font(.title)
                    

                }
                
                HStack(alignment: .top) {
                    Text(garbage)
                        .font(.subheadline)
                    Spacer()
                    Text(garbage)
                        .font(.subheadline)
                }
            }
            .padding()
            
            Spacer()
        }
    }
}

struct GarbageDetail_Previews: PreviewProvider {
    static var previews: some View {
        GarbageDetail(garbage: "Коробки")
    }
}
