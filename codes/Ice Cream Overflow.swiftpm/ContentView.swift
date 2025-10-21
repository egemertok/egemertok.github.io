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
    @State private var scoop1: Color? = nil
    @State private var scoop2: Color? = nil
    @State private var scoop3: Color? = nil
    @State private var scoop4: Color? = nil
    @State private var scoop5: Color? = nil
    
    @State private var count = 0
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Ice Cream Overflow")
                .font(.title2).bold()
                .offset(y: -200)
            
            HStack(spacing: 24) {
                VStack {
                    Text("Count")
                    Text("\(count)")
     
                }
                
                VStack {
                    Text("Binary")
                    Text(paddedBinary(count, width: 4))
                        
                }
            }
            .offset(y: -200)
            
            ZStack(alignment: .bottom) {
                if let c1 = scoop1 {
                    Circle().fill(c1).frame(width: 90, height: 90)
                        .offset(y: -80)
                }
                if let c2 = scoop2 {
                    Circle().fill(c2).frame(width: 90, height: 90)
                        .offset(y: -120)
                }
                if let c3 = scoop3 {
                    Circle().fill(c3).frame(width: 90, height: 90)
                        .offset(y: -160)
                }
                if let c4 = scoop4 {
                    Circle().fill(c4).frame(width: 90, height: 90)
                        .offset(y: -200)
                }
                if let c5 = scoop5 {
                    Circle().fill(c5).frame(width: 90, height: 90)
                        .offset(y: -240)
                }
                
                Triangle()
                    .fill(.brown)
                    .frame(width: 120, height: 110)
                    .padding(.bottom, 6)
            }
            .frame(height: 260)
            
            HStack(spacing: 12) {
                Button("Add Scoop") {
                    addScoop()
                }
                .buttonStyle(.borderedProminent)
                
                Button("Reset") {
                    resetAll()
                }
                .buttonStyle(.bordered)
            }
        }
        .padding()
    }
    
    func addScoop() {
        count = (count + 1) % 16
        
        if scoop1 == nil {
            scoop1 = nextColor()
        } else if scoop2 == nil {
            scoop2 = nextColor()
        } else if scoop3 == nil {
            scoop3 = nextColor()
        } else if scoop4 == nil {
            scoop4 = nextColor()
        } else if scoop5 == nil {
            scoop5 = nextColor()
        } else {
            print("Overflow → reset needed")
            resetAll()
        }
    }
    
    func resetAll() {
        scoop1 = nil
        scoop2 = nil
        scoop3 = nil
        scoop4 = nil
        scoop5 = nil
        count = 0
    }
    
    func nextColor() -> Color {
        let r = count % 5
        if r == 0 { return .pink }
        else if r == 1 { return .yellow }
        else if r == 2 { return .mint }
        else if r == 3 { return .orange }
        else { return .purple }
    }
    
    func paddedBinary(_ n: Int, width: Int) -> String {
        let s = String(n, radix: 2)
        let pad = max(0, width - s.count)
        return String(repeating: "0", count: pad) + s
    }
}

