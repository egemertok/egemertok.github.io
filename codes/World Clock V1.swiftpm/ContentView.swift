import SwiftUI

struct ContentView: View {
    
    let cities = ["London", "New York", "Tokyo", "Sydney", "Istanbul", "Rio de Janeiro"]
    let flags  = ["🇬🇧",     "🇺🇸",      "🇯🇵",   "🇦🇺",    "🇹🇷",      "🇧🇷"]
    
    let times  = ["10:24", "05:24", "18:24", "20:24", "12:24", "03:24"]
    
    var body: some View {
        VStack(spacing: 16) {
            
            Text("POST 5 – World Clock V1")
                .font(.title)
                .bold()
                .padding(.top)
            
            Text("City  —  Time")
                .font(.title2)
                .padding(.bottom, 8)
            

            ForEach(0..<cities.count, id: \.self) { index in
                HStack {
                    Text("\(flags[index]) \(cities[index])")
                        .font(.title3)
                    
                    Spacer()
                    
                    Text(times[index])
                        .font(.title3)
                        .monospacedDigit()
                }
                .padding(.horizontal)
            }
            
            Spacer()
        }
        .padding()
    }
}
