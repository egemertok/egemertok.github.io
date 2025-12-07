import SwiftUI

struct ContentView: View {
    // 3.10 List
    let temps = [70, 75, 80, 65]
    
    @State private var output = ""
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Scenario 3: Weather Check")
                .font(.headline)
            
            Button("Analyze Temps") {
                analyze()
            }
            
            Text(output)
                .padding()
            
            Text("• List holds the temps")
            Text("• Loop checks each one")
            Text("• Nested ifs describe the weather")
            Text("• Algorithm finds the highest temp")
        }
        .padding()
    }
    
    func analyze() {
        var text = ""
        var maxTemp = temps[0]     
        
        // 3.8 Iteration
        for t in temps {
            
            // 3.7 Nested Conditionals
            if t >= 75 {
                if t >= 80 {
                    text += "\(t): Very hot\n"
                } else {
                    text += "\(t): Warm\n"
                }
            } else {
                text += "\(t): Cool\n"
            }
    
            if t > maxTemp {
                maxTemp = t
            }
        }
        
        text += "Hottest temp: \(maxTemp)"
        output = text
    }
}

