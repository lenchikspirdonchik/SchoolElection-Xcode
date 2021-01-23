//
//  CircleImage.swift
//  iOS-No_To_Garbage
//
//  Created by Admin on 18.10.2020.
//

import SwiftUI

struct CircleImage: View {
    var image:Image

        
        var body: some View {
         
           /* image
                .resizable()
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 10)
                .frame(width: 200, height: 200, alignment: .center)*/
            
            if #available(iOS 14.0, *) {
                GeometryReader{ proxy in
                TabView{
                    ForEach (0..<7){number in
                        Image("\(number)")
                            .resizable()
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 4))
                            .shadow(radius: 10)
                            .frame(width: 200, height: 200, alignment: .center)
                        
                    }
                }.tabViewStyle(PageTabViewStyle())
                .padding()
                .clipShape(RoundedRectangle(cornerRadius: 25))
               // .frame(width: 200, height: 200, alignment: .center)
               // .frame(width: proxy.size.width, height: proxy.size.height / 2)
                }
            } else {
                // Fallback on earlier versions
            }
            
            
            
            
            
        }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage(image: Image("jars"))
    }
}
