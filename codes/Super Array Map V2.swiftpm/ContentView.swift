import SwiftUI

struct ContentView: View {
    
    let sports = [
        "⚽️ Soccer",
        "🏀 Basketball",
        "🏈 Football",
        "🎾 Tennis",
        "🏐 Volleyball",
        "⚾️ Baseball",
        "🏒 Hockey",
        "🥊 Boxing"
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            

            Text("Super Array List V2 – Sports")
                .font(.largeTitle)
                .bold()

            
    
            VStack(spacing: 15) {
                ForEach(0..<sports.count, id: \.self) { index in
                    HStack {
                        Text("(\(index))")      
                            .font(.title3)
                            .bold()
     
                        
                        Text(sports[index])    
                        
                            .font(.title3)
                        
                        Spacer()
                    }
                    .padding()
                    .background(Color.black.opacity(0.2))
                    .cornerRadius(10)
                    .padding(.horizontal)
                }
            }
            

            Text("Total Sports: \(sports.count)")
                .font(.title2)
                .bold()
        }
        .padding()
    }
}

