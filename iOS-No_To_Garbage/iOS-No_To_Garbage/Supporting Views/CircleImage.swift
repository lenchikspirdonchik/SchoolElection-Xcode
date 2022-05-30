//
//  CircleImage.swift
//  iOS-No_To_Garbage
//
//  Created by Admin on 18.10.2020.
//

import SwiftUI
struct CircleImage: View {
    var image:String
    @State var imageI:[UIImage] = [UIImage(imageLiteralResourceName: "logo")]
    var body: some View {
        GeometryReader{ proxy in
                TabView{
                    
                    ForEach(imageI, id:\.self){imageItem in
                        Image(uiImage: imageItem)
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .shadow(radius: 10)
                        .frame(width: 250, height: 250, alignment: .center)
                    }
                }.tabViewStyle(PageTabViewStyle())
                .padding()
                //.frame(width: 200, height: 200, alignment: .center)
                //.frame(width: proxy.size.width, height: proxy.size.height / 2)
            
        }.onAppear{
            GetPhoto().getPhoto(path: image) { (image) in
                imageI = image
            }
        }
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage(image: "jars")
    }
}
