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
    @State var numbers:[Int] = [0, 0, 0, 0, 0, 0, 0, 0, 0 ,0]
    var body: some View {
        
        BarChartView(data: ChartData(values: [("Батарейки", numbers[0]), ("Бумага", numbers[1]), ("Техника", numbers[2]), ("Бутылки", numbers[3]), ("Одежда в плохом состоянии", numbers[4]), ("Одежда в хорошем состоянии", numbers[5]), ("Стеклянные банки", numbers[6]), ("Контейнеры", numbers[7]), ("Коробки", numbers[8])]), title: "Sales", legend: "Quarterly", form: ChartForm.medium)
            .onAppear(){
            let myUid = currUser()?.uid
            if (myUid == nil){
                
            }else{
                getStatistics().getGarbage(uid: myUid!) { (done) in
                    numbers = done
                    print(numbers)
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
