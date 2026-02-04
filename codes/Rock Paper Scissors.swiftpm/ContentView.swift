import SwiftUI

struct ContentView: View {

let choices = ["🪨", "📄", "✂️"]
    
@State private var userChoice = "❓"
@State private var computerChoice = "❓"
@State private var resultText = "Make a choice!"
    
var body: some View {
VStack(spacing: 20) {
            
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
    
func randomComputerChoice() -> String {
return choices.randomElement() ?? "🪨"
    }
    
func determineWinner(userChoice: String, computerChoice: String) -> String {
        
if userChoice == computerChoice {
return "It's a tie!"
        }
        
if (userChoice == "🪨" && computerChoice == "✂️") ,
(userChoice == "📄" && computerChoice == "🪨") ,
(userChoice == "✂️" && computerChoice == "📄") {
return "You win!"
} 
else {
return "You lose!"
        }
    }

}

