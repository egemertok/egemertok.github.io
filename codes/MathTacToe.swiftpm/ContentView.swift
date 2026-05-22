import SwiftUI

struct ContentView: View {
    
    enum Difficulty: String, CaseIterable {
        case easy = "Easy"
        case medium = "Medium"
        case hard = "Hard"
    }
    
    @State private var isInGame = false
    @State private var board: [String] = Array(repeating: "", count: 9)
    @State private var playerScore = 0
    @State private var robotScore = 0
    @State private var round = 1
    @State private var totalRounds = 3
    @State private var difficulty: Difficulty = .easy
    
    @State private var selectedIndex: Int? = nil
    @State private var question = ""
    @State private var correctAnswer = 0
    @State private var userAnswer = ""
    @State private var status = "Answer a math question to place X!"
    @State private var gameOver = false
    
    private let wins: [[Int]] = [
        [0,1,2],[3,4,5],[6,7,8],
        [0,3,6],[1,4,7],[2,5,8],
        [0,4,8],[2,4,6]
    ]
    
    private let columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 3)
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            if isInGame {
                gameScreen
            } else {
                welcomeScreen
            }
        }
    }
    
    var welcomeScreen: some View {
        VStack(spacing: 20) {
            
            Text("MathTacToe")
                .foregroundColor(.black)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Rounds: \(totalRounds)")
                .foregroundColor(.black)
            
            Stepper("", value: $totalRounds, in: 1...10)
                .labelsHidden()
            
            Picker("Difficulty", selection: $difficulty) {
                ForEach(Difficulty.allCases, id: \.self) { level in
                    Text(level.rawValue)
                }
            }
            .foregroundColor(.black)
            .pickerStyle(.segmented)
            .padding()
            
            Button("Start") {
                startGame()
            }
            .font(.title2)
            .fontWeight(.bold)
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }
    
    var gameScreen: some View {
        VStack(spacing: 16) {
            Text("Round \(round) / \(totalRounds)")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.black)
            
            HStack {
                Text("You: \(playerScore)")
                Spacer()
                Text("Robot: \(robotScore)")
            }
            .font(.title3)
            .foregroundColor(.black)
            .padding(.horizontal)
            
            Text(status)
                .font(.title3)
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
            
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(0..<9, id: \.self) { i in
                    Button(action: {
                        chooseCell(i)
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.red)
                                .frame(width: 100, height: 100)
                            
                            
                            Text(board[i])
                                .font(.system(size: 44, weight: .bold))
                                .foregroundColor(.black)
                        }
                    }
                    .buttonStyle(.plain)
                    .disabled(gameOver || !board[i].isEmpty || selectedIndex != nil)
                }
            }
            
            if selectedIndex != nil {
                VStack(spacing: 10) {
                    Text(question)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                    TextField("Answer", text: $userAnswer)
                        .keyboardType(.numberPad)
                        .textFieldStyle(.roundedBorder)
                        .foregroundColor(.white)
                        .tint(.white)
                        .padding(.horizontal)
                    
                    Button("Submit Answer") {
                        checkMathAnswer()
                    }
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
            

            
            Button("Back to Menu") {
                isInGame = false
            }
            .foregroundColor(.red)
        }
        .padding()
    }
    
    private func startGame() {
        isInGame = true
        board = Array(repeating: "", count: 9)
        playerScore = 0
        robotScore = 0
        round = 1
        selectedIndex = nil
        userAnswer = ""
        status = "Answer a math question to place X!"
        gameOver = false
    }
    
    private func chooseCell(_ i: Int) {
        guard !gameOver, board[i].isEmpty else { return }
        selectedIndex = i
        generateQuestion()
    }
    
    private func generateQuestion() {
        let a: Int
        let b: Int
        
        if difficulty == .easy {
            a = Int.random(in: 1...10)
            b = Int.random(in: 1...10)
            correctAnswer = a + b
            question = "\(a) + \(b) = ?"
        } else if difficulty == .medium {
            a = Int.random(in: 10...30)
            b = Int.random(in: 1...10)
            correctAnswer = a - b
            question = "\(a) - \(b) = ?"
        } else {
            a = Int.random(in: 2...12)
            b = Int.random(in: 2...12)
            correctAnswer = a * b
            question = "\(a) × \(b) = ?"
        }
        
        userAnswer = ""
    }
    
    private func checkMathAnswer() {
        if Int(userAnswer) == correctAnswer {
            if let i = selectedIndex {
                board[i] = "X"
                selectedIndex = nil
                status = "Correct! Robot's turn."
                checkGameState()
                
                if !gameOver {
                    robotMove()
                    checkGameState()
                }
            }
        } else {
            selectedIndex = nil
            userAnswer = ""
            status = "Wrong answer! Robot's turn."
            
            if !gameOver {
                robotMove()
                checkGameState()
            }
        }
    }
    
func robotMove() {
        let emptyCells = board.indices.filter { board[$0].isEmpty }
        
        if let move = emptyCells.randomElement() {
            board[move] = "O"
            status = "Robot placed O. Your turn!"
        }
    }
    
 func checkGameState() {
        for line in wins where board[line[0]] != "" {
            if board[line[0]] == board[line[1]] &&
                board[line[1]] == board[line[2]] {
                
                if board[line[0]] == "X" {
                    playerScore += 1
                    status = "You won this round!"
                } else {
                    robotScore += 1
                    status = "Robot won this round!"
                }
                
                gameOver = true
                nextRound()
                return
            }
        }
        
        if board.allSatisfy({ !$0.isEmpty }) {
            status = "This round is a tie!"
            gameOver = true
            nextRound()
        }
    }
    
func nextRound() {
        if round < totalRounds {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                round += 1
                status = "Next round! Answer a math question to place X."
                resetRound()
            }
        } else {
            if playerScore > robotScore {
                status = "Game over! You beat the robot!"
            } else if robotScore > playerScore {
                status = "Game over! Robot wins!"
            } else {
                status = "Game over! It is a tie!"
            }
        }
    }
func resetRound() {
        board = Array(repeating: "", count: 9)
        selectedIndex = nil
        userAnswer = ""
        gameOver = false
    
}

    
}
