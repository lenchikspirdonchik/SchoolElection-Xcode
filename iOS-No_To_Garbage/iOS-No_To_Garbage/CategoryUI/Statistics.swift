//
//  Statistics.swift
//  iOS-No_To_Garbage
//
//  Created by Admin on 02.12.2020.
//
import SwiftUICharts
import SwiftUI
import FirebaseAuth


struct Statistics: View {
    @State var numbers:[(String,Double)] = []
    @State var text = "Загрузка"
    @State var result = [""]
    @State private var selected = 0
    let category:[String] = ["Батарейки", "Бумага", "Техника", "Бутылки", "Одежда в плохом состоянии", "Одежда в хорошем состоянии", "Стеклянные банки", "Контейнеры", "Коробки"]
    var body: some View {
        VStack {
            ScrollView{
                Text(text).bold()
                if !numbers.isEmpty{
                    BarChartView(data: ChartData(values: numbers), title: "Статистика", legend: "Так держать!", form: ChartForm.medium).padding(.horizontal, 50)
                    
                }
                Spacer()
                VStack{
                Picker(selection: $selected, label: Text("")) {
                    ForEach(0 ..< category.count) {
                        Text(self.category[$0])
                    }
                }
                .frame(height: 100)
                .clipped()
                .onTapGesture {
                    let user = currUser()
                    if (user != nil){
                        /*GetFromSQL().getFromSQL(uuid: user!.uid, category: category[selected]) { (res) in
                            result = res
                        }*/
                    }
                }
              
                List{
                    Text("text")
                    ForEach(result, id: \.self) { key in
                        
                        Text(key)
                    }
                }.onAppear{
                    let user = currUser()
                    if (user != nil){
                        GetFromSQL().getFromSQL(uuid: user!.uid, category: category[selected]) { (res) in
                            result = res
                        }
                    }
                }
                
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now()){
                    let myUid = currUser()?.uid
                    if (myUid != nil){
                        getStatistics().getGarbage(uid: myUid!) { (done) in
                            text = ""
                            numbers = done
                        }
                    }
                    else{
                        text = "Для начало нужно войти в аккаунт"
                    }
                }
            }
        }
        
        
    }
    
    
    
    func currUser() -> User? {
        let user = Auth.auth().currentUser
        return user
    }
}

struct Statistics_Previews: PreviewProvider {
    static var previews: some View {
        Statistics()
    }
}
