import SwiftUI

struct ContentView: View {
    
    let sports = ["Football", "Basketball", "Volleyball", "Tennis"]
    
    var body: some View {
        VStack(spacing: 30) {
            
           
            Text("My Array Map V1")
                .font(.largeTitle)
                .bold()

HStack(spacing: 20) {
ForEach(sports, id: \.self) { item in
Text(item)
.frame(width: 140, height: 70)
.bold()

                        
.font(.title3)
                }
            }
            
            VStack(spacing: 8) {
                Text("İndex:")
                    .font(.title2)
                    .bold()
               
                
                HStack(spacing: 95) {
                    
                    Text("0")
                    Text("1")
                    Text("2")
                    Text("3")
                }
                .font(.title2)
            }
           
            Text("Count: \(sports.count)")
                .font(.title2)
                .padding(.top, 20)
                .bold()
            
            
            
        }
        .padding()
    }
}
