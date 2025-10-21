import SwiftUI


struct ContentView: View {
    @State private var board: [String] = Array(repeating: "", count: 9)
    @State private var player: String = "X"
    @State private var status: String = ""
    @State private var gameOver: Bool = false
    
    
    private let wins: [[Int]] = [
        [0,1,2],[3,4,5],[6,7,8], 
        [0,3,6],[1,4,7],[2,5,8], 
        [0,4,8],[2,4,6] 
    ]
    
    
    private let columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 3)
    
    
    var body: some View {
        VStack(spacing: 16) {
            Text(status.isEmpty ? "Sıra: \(player)" : status)
                .font(.title3)
            
            
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(0..<9, id: \.self) { i in
                    Button(action: { tap(i) }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.blue)
                                .frame(width: 100, height: 100)
                            Text(board[i])
                                .font(.system(size: 44, weight: .bold))
                                .foregroundColor(.white)
                        }
                    }
                    .buttonStyle(.plain)
                    .disabled(gameOver || !board[i].isEmpty)
                }
            }
            
            
            Button("Yeniden Başlat", action: reset)
                .padding(.top, 4)
        }
        .padding()
    }
    
    
    private func tap(_ i: Int) {
        guard !gameOver, board[i].isEmpty else { return }
        board[i] = player
        checkGameState()
        if !gameOver { player = (player == "X") ? "O" : "X" }
    }
    
    
    private func checkGameState() {
        
        for line in wins where board[line[0]] != "" {
            if board[line[0]] == board[line[1]] && board[line[1]] == board[line[2]] {
                status = "\(board[line[0]]) kazandı!"
                gameOver = true
                return
            }
        }

        if board.allSatisfy({ !$0.isEmpty }) {
            status = "Berabere!"
            gameOver = true
        }
    }
    
    
    private func reset() {
        board = Array(repeating: "", count: 9)
        player = "X"
        status = ""
        gameOver = false
    }
}


#Preview {
    ContentView()
}
