//
//  GarbageDetail.swift
//  iOS-No_To_Garbage
//
//  Created by Admin on 18.10.2020.
//

import SwiftUI
import MapKit
import FirebaseDatabase

struct GarbageDetail: View {
    
    let garbage:String
    let garbageInfo = GetGarbageInfo()
    let mapInfo = GetMapInfo()
    @State var result = "Загрузка. Пожалуйста подожди("
    @State var result2 = "Заг подожди("
    var body: some View {

        let coordinate = [CLLocationCoordinate2D(latitude: 60.013219, longitude: 30.275225)]
        var hint = [""]
        
        let coor:[String : CLLocationCoordinate2D] = ["hint 0" : CLLocationCoordinate2D(latitude: 60.013219, longitude: 30.275225)]
        
        let photo:[String : String] = [ "Батарейки" : "battery" , "Бумага" : "paper" , "Техника" : "technic" , "Бутылки" : "kitchenbottles", "Бутылки " : "bathbottles" , "Одежда в плохом состоянии" : "badclothes" , "Одежда в хорошем состоянии" : "goodclothes" , "Стеклянные банки" : "jars" , "Контейнеры" : "containers" , "Коробки" : "box"]
        
        
        
        ScrollView(.vertical, showsIndicators: false)  {
            MapView(coordinate: coordinate, hint: hint)
                .edgesIgnoringSafeArea(.top)
                .frame(height: 450)
                .onAppear(){
                   mapInfo.getMap(path: garbage) { ([String : CLLocationCoordinate2D]) in   }
                    
                }
            
            CircleImage(image: Image(photo[garbage]!))
                .offset(x: 0, y: -60)
                .padding(.bottom, -80)
            
            VStack(alignment: .leading) {
                
                Text(garbage)
                    .font(.title)
                
                
               Text (result2)
                    .onAppear{
                        mapInfo.getNumber(path: garbage) { (number) in
                            mapInfo.getHint(path: garbage, trueMapNumber: number) { (resArr) in
                                print("hintarr2 \(resArr)")
                                result2 = resArr[1]
                            }
                        }
                        
                        
                    }
                
                Text(result)
                    .font(.subheadline)
                    .onAppear {
                    garbageInfo.getInfo(path: garbage) { resultString in
                        result = resultString
                    }
                }
                
                
            }
            .padding()
            
            Spacer()
        }.padding(.top, -20)
        
        
    }
    
}



struct GarbageDetail_Previews: PreviewProvider {
    static var previews: some View {
        
        GarbageDetail(garbage: "Коробки")
    }
}



