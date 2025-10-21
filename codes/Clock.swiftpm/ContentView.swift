import SwiftUI

struct ContentView: View {
    @State private var hour: Int = 0
    @State private var minuteSeg: Double = 0
    
    var body: some View {
        ZStack {
            if hour < 12 {
                Circle()
                    .frame(width: 300, height: 300)
                    .foregroundStyle(.yellow)
            } else {
                Circle()
                    .frame(width: 300, height: 300)
                    .foregroundStyle(.blue)
            }
            
            // Center dot
            Circle()
                .frame(width: 20, height: 20)
                .foregroundStyle(.black)
            
            // Yelkovan (minute hand)
            Rectangle()
                .frame(width: 10, height: 100)
                .offset(x:0, y: -50)
                .rotationEffect(.degrees(minuteSeg))
                .foregroundStyle(.black)
            
            // Akrep (hour hand)
            Rectangle()
                .frame(width: 17, height: 70)
                .offset(y: -35)
                .rotationEffect(.degrees(Double(hour * 30)))
                .foregroundStyle(.black)
              
           
            
            
            Text("Hour: \(hour)")
                .offset(y: -200)
            }
        
        .contentShape(Rectangle()) 
        .onTapGesture {
            
                minuteSeg += 90
                if minuteSeg >= 360 { minuteSeg = 0 
                    hour=hour+1
                    
                }
                if hour==24 {hour=0}
                    
        
        }
    }
}

    
