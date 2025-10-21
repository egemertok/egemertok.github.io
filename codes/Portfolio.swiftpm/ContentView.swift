import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            
            Rectangle()
                .frame(width:100, height:200)
                .offset(y:200)
                .foregroundStyle(Color.brown)
            
            Capsule()
                .frame(width: 300, height: 350)
                .foregroundStyle(Color.brown)
            RoundedRectangle(cornerRadius:70)
                .foregroundStyle(.indigo)
                .frame(width: 500, height: 600)
                .offset(y:550)
            
            Ellipse()
                .frame(width:200, height:130)
                .offset(x:70, y:-150)
                .foregroundStyle(Color.black)
            Ellipse()
                .frame(width:200, height:130)
                .offset(x:-70, y:-150)
                .foregroundStyle(Color.black)
            Ellipse()
                .frame(width:200, height:130)
                .offset(x:0, y:-150)
                .foregroundStyle(Color.black)
            Ellipse()
                .frame(width:70, height:130)
                .offset(x:-150, y:-50)
                            .foregroundStyle(Color.black)
            Ellipse()
                .frame(width:70, height:130)
                .offset(x:150, y:-50)
                            .foregroundStyle(Color.black)
            Ellipse()
                .frame(width:85, height:130)
                .offset(x:150, y:-100)
                            .foregroundStyle(Color.black)
            Ellipse()
                .frame(width:85, height:130)
                .offset(x:-150, y:-100)
                            .foregroundStyle(Color.black)
            Ellipse()
                .frame(width:65, height: 50)
                .offset(x:-55, y:0)
            Ellipse()
                .frame(width:65, height: 50)
                .offset(x:55, y:0)
            Circle()
                .frame(width:30)
                .offset(x:55)
                .foregroundStyle(Color.black)
            Circle()
                .frame(width:30)
                .offset(x:-55)
                .foregroundStyle(Color.black)
            
            
            
            
            
        }
    }
}
