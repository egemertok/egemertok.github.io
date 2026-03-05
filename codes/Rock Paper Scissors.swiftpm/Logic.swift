import SwiftUI

let choices = ["🪨", "📄", "✂️"]

var userChoice = "❓"
var computerChoice = "❓"
var comwin = 0
var plwin = 0
var whowin : String = ""





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
        plwin=plwin+1
        if plwin == 3 {
            whowin = "Player Wins!" 
            comwin = 0
            plwin = 0
        }
        return "You win!"
    } 
    else {
        comwin=comwin+1
        if comwin == 3 {
            whowin = "Computer Wins!" 
            comwin = 0
            plwin = 0
            }
        return "You lose!"
    }
}



    
    
    
    
    

