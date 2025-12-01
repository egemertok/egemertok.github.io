import SwiftUI

struct ContentView: View {
    @State private var currentColor: Color = .gray
    @State private var colorName: String = "Waiting..."
    @State private var blueCount = 0
    @State private var orangeCount = 0
    @State private var purpleCount = 0
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Spinner Simulation")
                .font(.largeTitle)
                .bold()
            ZStack {
                Rectangle()
                    .fill(currentColor)
                    .frame(width: 180, height: 180)
                    .cornerRadius(12)
                Text(colorName).foregroundColor(.white).font(.title2).bold()
            }
            
            Button("Spin") { spin() }
                .font(.title2).padding().bold()
            
            VStack {
                Text("Blue: \(blueCount)  |  Orange: \(orangeCount)  |  Purple: \(purpleCount)")
                    .font(.headline)
            }
            
            Spacer()
        }
        .padding()
    }
    
    func spin() {
        let first = Int.random(in: 1...2)
        if first == 1 {
            currentColor = .blue
            colorName = "Blue"
            blueCount += 1
        } 
        else 
        {
            let second = Int.random(in: 1...2) 
            if second == 1 {
                currentColor = .orange
                colorName = "Orange"
                orangeCount += 1
            } else {
                currentColor = .purple
                colorName = "Purple"
                purpleCount += 1
            }
        }
    }
}



