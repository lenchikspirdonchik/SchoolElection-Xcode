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
    @State var numbers:[Int] = [1,1,1,1,1,1,1,1]
    @State var chartData: [Double] = [0, 5, 6, 2, 13, 4, 3, 6]
    var body: some View {
       
        
        
        BarChartView(data: ChartData(values: [("Батарейки", numbers[0]), ("Бумага", numbers[1]), ("Техника", numbers[2])]), title: "Sales", legend: "Quarterly", form: ChartForm.extraLarge)
          .onAppear {
                let myUid = currUser()?.uid
                if (myUid != nil){
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
