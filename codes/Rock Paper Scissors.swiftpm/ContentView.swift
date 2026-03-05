import SwiftUI

struct ContentView: View {


@State private var resultText = "Make a choice!"

    
var body: some View {
VStack(spacing: 20) {

Text("\(whowin)")
    
Text("Computer Wins: \(comwin)")
Text("Player Wins: \(plwin)")
            
Text("Rock Paper Scissors")
.font(.largeTitle)
            
Text("You: \(userChoice)")
.font(.title2)
            
Text("Computer: \(computerChoice)")
.font(.title2)
            
Text(resultText)
.font(.title)
.padding()
            
HStack(spacing: 20) {
ForEach(choices, id: \.self) { choice in
Button(action: {
playGame(userPicked: choice)
}) {
Text(choice)
.font(.system(size: 60))
                    }
                }
            }
    
    
    
    
            
Button("Restart") {
userChoice = "❓"
computerChoice = "❓"
resultText = "Make a choice!"
whowin = ""
comwin = 0
plwin = 0

            }
.padding(.top, 20)
        }
.padding()
    }
    

func playGame(userPicked: String) {
userChoice = userPicked
computerChoice = randomComputerChoice()
resultText = determineWinner(userChoice: userChoice, computerChoice: computerChoice)
    }
    


}

