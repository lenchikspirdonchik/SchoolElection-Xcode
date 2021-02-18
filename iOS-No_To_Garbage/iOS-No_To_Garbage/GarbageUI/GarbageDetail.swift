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
    let garbageInfo = GetGarbageInfo()
    let mapInfo = GetMapInfo()
    @State var result = "Загрузка. Пожалуйста подожди("
    @State var resArray = [(CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0), "Загрузка", "Загрузка")]
    var body: some View {
        
        
        /*   let photo:[String : String] = [ "Батарейки" : "battery" , "Бумага" : "paper" , "Техника" : "technic" , "Бутылки" : "kitchenbottles", "Бутылки " : "bathbottles" , "Одежда в плохом состоянии" : "badclothes" , "Одежда в хорошем состоянии" : "goodclothes" , "Стеклянные банки" : "jars" , "Контейнеры" : "containers" , "Коробки" : "box"]*/
        
        
        
        ScrollView(.vertical, showsIndicators: false)  {
            MapView(resArray: resArray)
                .edgesIgnoringSafeArea(.top)
                .frame(height: 450)
                .onAppear{
                    var realPath = garbage
                    if garbage == "Бутылки "{
                        realPath = "Бутылки"
                    }
                    let text = "SELECT * FROM no2garbage_map WHERE category = '\(realPath)';"
                    GetMapInfo().getMap(path: text) { (resArr) in
                        resArray = resArr
                    }
                }
            
            
            CircleImage(image: garbage)
                .offset(x: 0, y: -60)
                .padding(.bottom, -70)
            
            
            Text(garbage)
                .font(.title)
                .padding(.top, 140)
            
            
            Text(result)
                .font(.subheadline)
                .onAppear {
                    garbageInfo.getInfo(path: garbage) { resultString in
                        result = resultString.replacingOccurrences(of: "_n", with: "\n")
                    }
                }
                .padding()
            
            
        }.padding(.top, -20)
        
    }
    
}



struct GarbageDetail_Previews: PreviewProvider {
    static var previews: some View {
        
        GarbageDetail(garbage: "Коробки")
    }
}



