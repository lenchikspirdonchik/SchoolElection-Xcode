//
//  Test.swift
//  iOS-No_To_Garbage
//
//  Created by Ольга Завьялова on 23.01.2021.
//

import SwiftUI

struct Test: View {
    let countNumber = 7
    var body: some View {
        if #available(iOS 14.0, *) {
            GeometryReader{ proxy in
            TabView{
                ForEach (0..<countNumber){number in
                    Image("\(number)")
                        .resizable()
                        .scaledToFit()
                    
                }
            }.tabViewStyle(PageTabViewStyle())
            .padding()
            .clipShape(RoundedRectangle(cornerRadius: 25))
            .frame(width: 200, height: 200, alignment: .center)
           // .frame(width: proxy.size.width, height: proxy.size.height / 2)
            }
        } else {
            // Fallback on earlier versions
        }
    }
}


struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
    }
}
