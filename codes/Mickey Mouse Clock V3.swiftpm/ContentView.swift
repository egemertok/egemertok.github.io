import SwiftUI

struct ContentView: View {
    @State private var hour: Int = 0
    @State private var minuteSeg: Double = 0
    
    var body: some View {
        VStack {
            // Hour display at the top
            Text("Hour: \(hour)")
                .padding(.bottom, 10)
            
            HStack {
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
                
                // AM/PM color indicator
                if hour < 12 {
                    Ellipse()
                        .frame(width: 35, height: 70)
                        .foregroundStyle(.yellow)
                        .offset(x:60, y: -40)
                    Ellipse()
                        .frame(width: 35, height: 70)
                        .foregroundStyle(.yellow)
                        .offset(x:-60, y: -40)
                } else {
                    Ellipse()
                        .frame(width: 35, height: 70)
                        .foregroundStyle(.blue)
                        .offset(x:60, y: -40)
                    Ellipse()
                        .frame(width: 35, height: 70)
                        .foregroundStyle(.blue)
                        .offset(x:-60, y: -40)
                }
                
                // Numbers 1–12 around the clock
                ForEach(1...12, id: \.self) { num in
                    let angle = Double(num) * 30.0
                    Text("\(num)")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(.black)
                    // keep text upright
                        .rotationEffect(.degrees(-angle))
                    // push to outer circle
                        .offset(y: -135)
                    // rotate around center
                        .rotationEffect(.degrees(angle))
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
                
                // Minute hand
                Rectangle()
                    .frame(width: 10, height: 100)
                    .offset(x:0, y: -50)
                    .rotationEffect(.degrees(minuteSeg))
                    .foregroundStyle(.black)
                
                // Hour hand
                Rectangle()
                    .frame(width: 17, height: 70)
                    .offset(y: -35)
                    .rotationEffect(.degrees(Double(hour % 12) * 30))
                    .foregroundStyle(.black)
            }
            .frame(width: 300, height: 300)
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation(.easeInOut) {
                    minuteSeg += 90
                    if minuteSeg >= 360 {
                        minuteSeg = 0
                        hour = (hour + 1) % 24
                    }
                }
            }
            
            // Buttons to change hour
            HStack {
                Button("Hour-") {
                    withAnimation {
                        hour = (hour - 1 + 24) % 24
                    }
                }
                .padding()
                .background(Color.red.opacity(0.2))
                .cornerRadius(10)
                
                Button("Hour+") {
                    withAnimation {
                        hour = (hour + 1) % 24
                    }
                }
                .padding()
                .background(Color.green.opacity(0.2))
                .cornerRadius(10)
                
                Button("Random Hour") {
                    withAnimation {
                        hour = Int.random(in: 0..<24)
                    }
                }
                .padding()
                .background(Color.blue.opacity(0.2))
                .cornerRadius(10)
                
                Button("Next Minute") {
                    withAnimation {
                        minuteSeg += 90
                        if minuteSeg >= 360 {
                            minuteSeg = 0
                            hour = (hour + 1) % 24
                        }
                    }
                }
            }
            .padding(.top, 20)
        }
    }
}
