import SwiftUI
struct ContentView: View {
    @State var n1=""
    @State var n2=""
    @State var result=0
    var body: some View {
        VStack {
            Text("Simple Calculator")
            TextField("Enter first number", text:$n1)
            TextField("Enter first number", text:$n2)  
            HStack (spacing:15) {  
                Button("+") {
                    if let a=Int(n1), let b=Int(n2) {
                        result=a+b
                    }
                }
                Button("-") {    
                    if let a=Int(n1), let b=Int(n2) {
                        result=a-b
                    }
                }
                Button("*") {
                    if let a=Int(n1), let b=Int(n2) { 
                        result=a*b
                    }
                }
                Button("/") {     
                    if let a=Int(n1), let b=Int(n2) {
                        result=a/b
                    }
                }     
            }
            .buttonStyle(.borderedProminent)
            Text("Result: \(result)")
        }
    }
}



