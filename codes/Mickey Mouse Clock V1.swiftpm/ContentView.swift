import SwiftUI

struct ContentView: View {
    @State private var hour: Int = 0
    @State private var minuteSeg: Double = 0
    
    var body: some View {
        HStack{
           Circle()
                .frame(width:150)
                .foregroundStyle(.black)
                .offset(x:200, y:80)
            Circle()
                .frame(width:150)
                .foregroundStyle(.black)
                .offset(x:-200, y:80)
            
            }
        ZStack {
           Circle()
                .frame(width:325, height: 325)
                .foregroundStyle(.black)
                Circle()
                    .frame(width: 300, height: 300)
                    .foregroundStyle(.white)
        if hour<12 {
            Ellipse()
                .frame(width: 35, height: 70)
                .foregroundStyle(.yellow)
                .offset(x:60, y: -40)
            Ellipse()
                .frame(width: 35, height: 70)
                .foregroundStyle(.yellow)
                .offset(x:-60, y: -40) 
            }
            else{
                Ellipse()
                    .frame(width: 35, height: 70)
                    .foregroundStyle(.blue)
                    .offset(x:60, y: -40)
                Ellipse()
                    .frame(width: 35, height: 70)
                    .foregroundStyle(.blue)
                    .offset(x:-60, y: -40) 
            }
            
            // Center dot
            Circle()
                .frame(width: 40, height: 40)
                .foregroundStyle(.black)
            
            
            Ellipse()
                .frame(width:150, height: 50)
                .foregroundStyle(.black)
                .offset(y:60)
            Ellipse()
                .frame(width:150, height: 50)
                .foregroundStyle(.white)
                .offset(y:45)
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
            withAnimation(.easeInOut) {
                minuteSeg += 90
                if minuteSeg >= 360 { minuteSeg = 0 
                    hour=hour+1
                    
                }
                if hour==24 {hour=0}
                
            }
        }
    }
}



