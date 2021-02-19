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
            VStack{
                TabView{
                    ForEach (imageI, id: \.self){myUiImage in
                        Image(uiImage: myUiImage)
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 4))
                            .shadow(radius: 10)
                            .frame(width: 200, height: 200, alignment: .center)
                    }
                }
                .tabViewStyle(PageTabViewStyle())
                .padding()    
            }
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
