import SwiftUI

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.closeSubpath()
        return path
    }
}

struct ContentView: View {
    let flavor = [ 
        "Vanilla ⚪️",
        "Choclate 🟤",
        "Strawberry 🔴",
        "Caramel 🟠",
        "Banana 🟡"
    ]

  
        
        
        
        
    
    var body: some View {
        
        
        Text("Ice Cream Flavor Choose")
            .font(.largeTitle)
            .bold()
        
        
        
        VStack(spacing: 15) {
            ForEach(0..<flavor.count, id: \.self) { index in
                HStack {
                    Text("(\(index))")      
                        .font(.title3)
                        .bold()
                    
                    
    Text(flavor[index])    
    .font(.title3)
                    
                    Spacer() 
                        
                }
                .padding()
                .background(Color.black.opacity(0.2))
                .cornerRadius(10)
                .padding(.horizontal)
               
                
            }
            
          Triangle()
                .fill(.brown)
                .frame(width: 300, height: 300)
                .padding(.bottom, 6)
            
                        }

            
            
        }
        
    }
    
