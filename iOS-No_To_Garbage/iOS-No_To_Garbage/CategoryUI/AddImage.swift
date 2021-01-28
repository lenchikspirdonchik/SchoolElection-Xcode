//
//  AddImage.swift
//  iOS-No_To_Garbage
//
//  Created by Admin on 28.01.2021.
//

import SwiftUI

struct AddImage: View {
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var image: Image?
    @State private var filterIntensity = 0.5
    @State var showAlert = false
    @State var showGoodAlert = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let category:[String] = ["Батарейки", "Бумага", "Техника", "Бутылки", "Одежда в плохом состоянии", "Одежда в хорошем состоянии", "Стеклянные банки", "Контейнеры", "Коробки"]
    @State private var selected = 0
    var body: some View {
        //  NavigationView {
        VStack {
            ZStack {
                Rectangle()
                    .fill(Color.secondary)
                
                if  image !=  nil {
                    image?
                        .resizable()
                        .scaledToFit()
                } else {
                    Text("Нажмите, чтобы выбрать фотографию")
                        .foregroundColor(.white)
                        .font(.headline)
                }
            }
            .padding(.horizontal, 5)
            .onTapGesture {
                self.showingImagePicker = true
            }
            
            Picker(selection: $selected, label: Text("")) {
                ForEach(0 ..< category.count) {
                    Text(self.category[$0])
                }
            }
            .frame(height: 100)
            .clipped()
            
            HStack {
                //Button("Change Filter") { change filter}
                
                Spacer()
                
                Button("Добавить") {
     
                    GetPhoto().setPhoto(path: category[selected], image: inputImage!) { (result) in
                        print(result)
                        showGoodAlert = result
                        self.showAlert.toggle()
                    }
                }
                .alert(isPresented: $showAlert) { () -> Alert in
                    
                    if (showGoodAlert){
                        let button = Alert.Button.default(Text("OK")) {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                        return Alert(title: Text("Поздравляем!"), message: Text("Вы успешно добавали картинку!"), dismissButton: button)
                    }else{
                        
                        let primaryButton = Alert.Button.cancel(Text("Конечно!")) {
                            print("primary button pressed")
                        }
                        let secondaryButton = Alert.Button.destructive(Text("в следующий раз")) {
                            print("secondary button pressed")
                            self.presentationMode.wrappedValue.dismiss()
                        }
                        return Alert(title: Text("Произошла ошибка("), message: Text("Повторим еще раз?"), primaryButton: primaryButton, secondaryButton: secondaryButton)
                    }
                }
                Spacer()
            }
        }
        .padding([.horizontal, .bottom])
        .navigationBarTitle("Добавить картинку")
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: self.$inputImage)
        }
        //}
    }
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
}

struct AddImage_Previews: PreviewProvider {
    static var previews: some View {
        AddImage()
    }
}
