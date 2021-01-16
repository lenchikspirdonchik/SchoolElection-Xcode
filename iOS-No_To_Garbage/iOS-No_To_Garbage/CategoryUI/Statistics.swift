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
    var body: some View {
        VStack {
            Text(text).bold()
            if !numbers.isEmpty{
                BarChartView(data: ChartData(values: numbers), title: "Статистика", legend: "Так держать!", form: ChartForm.extraLarge).padding(.horizontal, 50)
                
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
