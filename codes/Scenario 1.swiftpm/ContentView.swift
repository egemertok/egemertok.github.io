import SwiftUI

struct ContentView: View {
    // 3.1 Variables and Assignments
    @State private var hours = ""
    @State private var rate = ""
    @State private var result = ""
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Scenario 1: Pay Calculator")
                .font(.headline)
            
            TextField("Hours worked", text: $hours)
                .textFieldStyle(.roundedBorder)
            TextField("Hourly rate", text: $rate)
                .textFieldStyle(.roundedBorder)
            
            Button("Calculate") {
                calculatePay()
            }
            
            Text(result)
                .padding()
            
            Text("• Variables store hours and rate")
            Text("• Function hides the calculation")
            Text("• Math = hours × rate")
        }
        .padding()
    }
    
    // 3.2 Data Abstraction: simple function
    func pay(hours: Double, rate: Double) -> Double {
        // 3.3 Mathematical Expression
        return hours * rate
    }
    
    func calculatePay() {
        let h = Double(hours) ?? 0
        let r = Double(rate) ?? 0
        let total = pay(hours: h, rate: r)
        result = "Pay: $\(total)"
    }
}

