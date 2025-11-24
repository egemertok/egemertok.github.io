import SwiftUI

struct ContentView: View {
    let cells = Array(0..<100)
    @State private var cellColors: [Color] = Array(repeating: .gray, count: 100)
    @State private var inputText: String = ""
    @State private var message: String = ""
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Pixel Painter 10×10")
                .font(.title)
                .bold()
            
            HStack {
                TextField("Enter a cell number (0–99)", text: $inputText)
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button("Paint") {
                    changeColor()
                }
            }
            

            if !message.isEmpty {
                Text(message)
                    .foregroundColor(.red)
            }
            

            drawGrid()
            
            Spacer()
        }
        .padding()
    }
    

    func drawGrid() -> some View {
        VStack(spacing: 2) {

            ForEach(0..<10, id: \.self) { row in
                HStack(spacing: 2) {

                    ForEach(0..<10, id: \.self) { col in
                        let index = row * 10 + col
                        
                        Text("\(index)")
                            .frame(width: 30, height: 30)
                            .background(cellColors[index])
                            .border(Color.black, width: 1)
                            .font(.caption)
                    }
                }
            }
        }
    }
    

    func changeColor() {
  
        if let number = Int(inputText) {

            if number >= 0 && number < 100 {
 
                cellColors[number] = .blue
                message = ""         
            } else {
                print("Invalid input")
                message = "Invalid input"
            }
        } else {
                      print("Invalid input")
            message = "Invalid input"
        }
    }
}

