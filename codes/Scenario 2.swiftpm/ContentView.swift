import SwiftUI

struct ContentView: View {
    // 3.4 Strings
    let correctUser = "student"
    let correctPass = "1234"
    
    @State private var username = ""
    @State private var password = ""
    @State private var message = ""
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Scenario 2: Login Check")
                .font(.headline)
            
            TextField("Username", text: $username)
                .textFieldStyle(.roundedBorder)
            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
            
            Button("Log In") {
                check()
            }
            
            Text(message)
                .padding()
            
            Text("• Strings store names/passwords")
            Text("• Booleans compare values")
            Text("• If/else picks the result")
        }
        .padding()
    }
    
    func check() {
        // 3.5 Boolean Expressions
        let userOK = (username == correctUser)
        let passOK = (password == correctPass)
        
        // 3.6 Conditionals
        if userOK && passOK {
            message = "Login successful!"
        } else {
            message = "Login failed."
        }
    }
}

