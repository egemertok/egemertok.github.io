import SwiftUI

let choices = ["🪨", "📄", "✂️"]

var userChoice = "❓"
var computerChoice = "❓"

func randomComputerChoice() -> String {
    return choices.randomElement() ?? "🪨"
}

func determineWinner(userChoice: String, computerChoice: String) -> String {
    
    if userChoice == computerChoice {
        return "It's a tie!"
    }
    
    if (userChoice == "🪨" && computerChoice == "✂️") ||
       (userChoice == "📄" && computerChoice == "🪨") ||
       (userChoice == "✂️" && computerChoice == "📄") {
        return "You win!"
    } 
    else {
        return "You lose!"
    }
}

