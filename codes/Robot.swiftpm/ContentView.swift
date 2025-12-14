import SwiftUI

enum Direction { case up, down, left, right }

struct Move {
    let direction: Direction
    let steps: Int
}

struct ContentView: View {
    @State private var robotRow = 0
    @State private var robotCol = 0
    @State private var message = "Ready"
    
    let gridSize = 10
    
    // Array 1
    let obstacles: [(Int, Int)] = [(2,2), (2,3), (4,5), (6,1), (7,7)]
    
    // Array 2
    let movesList: [Move] = [
        Move(direction: .right, steps: 3),
        Move(direction: .down, steps: 2),
        Move(direction: .right, steps: 2),
        Move(direction: .down, steps: 3),
        Move(direction: .left, steps: 1)
    ]
    
    var body: some View {
        VStack(spacing: 12) {
            Text("Robot Movement Simulation").font(.title).bold()
            Text(message)
            
            drawGrid(size: gridSize)
            
            VStack(spacing: 10) {
                Button("⬆️") { move(direction: .up, steps: 1) }
                HStack(spacing: 20) {
                    Button("⬅️") { move(direction: .left, steps: 1) }
                    Button("⬇️") { move(direction: .down, steps: 1) }
                    Button("➡️") { move(direction: .right, steps: 1) }
                }
                Button("Run List") { runMoves(list: movesList) }
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
    
    // Function 1
    @ViewBuilder
    func drawGrid(size: Int) -> some View {
        VStack(spacing: 2) {
            ForEach(0..<size, id: \.self) { row in
                HStack(spacing: 2) {
                    ForEach(0..<size, id: \.self) { col in
                        ZStack {
                            Rectangle()
                                .strokeBorder(lineWidth: 1)
                                .frame(width: 34, height: 34)
                                .background(cellColor(row: row, col: col))
                            
                            if row == robotRow && col == robotCol {
                                Rectangle().fill(Color.black).frame(width: 30, height: 30)
                            }
                        }
                    }
                }
            }
        }
    }
    
    // Function 2 
    func cellColor(row: Int, col: Int) -> Color {
        if isObstacle(row: row, col: col) { return .red.opacity(0.35) } // if/else 1
        else { return .clear }
    }
    
    // Function 3 
    func isObstacle(row: Int, col: Int) -> Bool {
        obstacles.contains(where: { $0.0 == row && $0.1 == col })
    }
    
    // Function 4
    func inBounds(row: Int, col: Int) -> Bool {
        row >= 0 && row < gridSize && col >= 0 && col < gridSize
    }
    
    // Function 5
    func move(direction: Direction, steps: Int) {
        for _ in 0..<steps {
            var newRow = robotRow
            var newCol = robotCol
            
            switch direction {
            case .up: newRow -= 1
            case .down: newRow += 1
            case .left: newCol -= 1
            case .right: newCol += 1
            }
            
            if inBounds(row: newRow, col: newCol) {                 // if/else 2
                if isObstacle(row: newRow, col: newCol) {           // if/else 3 (nested)
                    message = "Blocked"
                } else {
                    robotRow = newRow
                    robotCol = newCol
                    if robotRow == 9 && robotCol == 9 {             // if/else 4
                        message = "Reached (9,9)"
                    } else {
                        message = "Moved"
                    }
                }
            } else {
                if robotRow == 0 && direction == .up {              // if/else 5 (nested)
                    message = "Top edge"
                } else {
                    message = "Out of bounds"
                }
            }
        }
    }
    
  
    func runMoves(list: [Move]) {
        for m in list {                                             // For-loop
            if message == "Blocked" { break }              
            move(direction: m.direction, steps: m.steps)
        }
    }
}


