import SwiftUI

struct ContentView: View {
    @State private var isInMenu = false
    
    @State private var wakeTimeText = "08:00"
    @State private var sleepTimeText = "22:00"
    
    @State private var medName = ""
    @State private var dosage = ""
    @State private var timeText = "" 
    
    
    
    struct Medicine: Identifiable {
        let id = UUID()
        var name: String
        var dosage: String
        var time: String
        var takenToday: Bool
    }
    
    @State private var medicines: [Medicine] = []
    
    enum MenuSection { case main, setSchedule, addMedicine, today }
    @State private var section: MenuSection = .main
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            if isInMenu {
                menuScreen
            } else {
                welcomeScreen
            }
        }
    }
    
    
    var welcomeScreen: some View {
        VStack {
            
            Image("Logo")
                .resizable()
                .frame(width:300, height:300)
            
            Text("MediMate")
                .foregroundColor(.black)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Button("Start") {
                isInMenu = true
                section = .main
            }
            .font(.title2)
            .fontWeight(.bold)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
    }
    
    var menuScreen: some View {
        ZStack {
            VStack(spacing: 16) {
                switch section {
                    
                case .main:
                    Text("Medicine Reminder Menu")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                    VStack(spacing: 12) {
                        
                        
                        Text("Options")
                            .font(.headline)
                            .foregroundColor(.black)
                        
                        Button("Set Schedule") {
                            section = .setSchedule
                        }
                        .buttonStyle(.bordered)
                        .tint(.blue)
                        
                        Button("Add a Medicine") {
                            section = .addMedicine
                        }
                        .buttonStyle(.bordered)
                        .tint(.blue)
                        
                        Button("Today's List / Summary") {
                            section = .today
                        }
                        .buttonStyle(.bordered)
                        .tint(.blue)
                        
                        Button("Exit") {
                            section = .main
                            isInMenu = false
                        }
                        .buttonStyle(.bordered)
                        .tint(.blue)
                    }
                    
                case .setSchedule:
                    VStack(spacing: 12) {
                        Text("Set Schedule")
                            .foregroundColor(.black)
                            .font(.title)
                            .bold()
                        
                        Text("Your typical day helps you plan reminders.")
                            .foregroundColor(.black.opacity(0.7))
                            .multilineTextAlignment(.center)
                        
                        TextField("Wake time (e.g. 08:00)", text: $wakeTimeText)
                            .textFieldStyle(.roundedBorder)
                            .frame(maxWidth: 260)
                        
                        TextField("Sleep time (e.g. 22:00)", text: $sleepTimeText)
                            .textFieldStyle(.roundedBorder)
                            .frame(maxWidth: 260)
                        
                        Button("Save Schedule") {
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.blue)
                        
                        Button("Back to Menu") {
                            section = .main
                        }
                        .buttonStyle(.bordered)
                    }
                    
                case .addMedicine:
                    VStack(spacing: 12) {
                        Text("Add Medicine")
                            .foregroundColor(.black)
                            .font(.title)
                            .bold()
                        
                        TextField("Medicine name (e.g. Vitamin D)", text: $medName)
                            .textFieldStyle(.roundedBorder)
                            .frame(maxWidth: 260)
                        
                        TextField("Dosage (e.g. 1 tablet)", text: $dosage)
                            .textFieldStyle(.roundedBorder)
                            .frame(maxWidth: 260)
                        
                        TextField("Time (HH:mm, e.g. 09:00)", text: $timeText)
                            .textFieldStyle(.roundedBorder)
                            .frame(maxWidth: 260)
                        
                        Button("Add") {
                            let cleanName = medName.trimmingCharacters(in: .whitespacesAndNewlines)
                            let cleanDosage = dosage.trimmingCharacters(in: .whitespacesAndNewlines)
                            let cleanTime = timeText.trimmingCharacters(in: .whitespacesAndNewlines)
                            
                            if !cleanName.isEmpty && !cleanTime.isEmpty {
                                medicines.append(
                                    Medicine(name: cleanName,
                                             dosage: cleanDosage.isEmpty ? "—" : cleanDosage,
                                             time: cleanTime,
                                             takenToday: false)
                                )
                                medName = ""
                                dosage = ""
                                timeText = ""
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.blue)
                        
                        Button("Back to Menu") {
                            section = .main
                        }
                        .buttonStyle(.bordered)
                    }
                    
                case .today:
                    VStack(spacing: 10) {
                        Text("Today's Summary")
                            .font(.title)
                            .foregroundColor(.black)
                            .bold()
                        
                        Text("Wake: \(wakeTimeText)   •   Sleep: \(sleepTimeText)")
                            .foregroundColor(.black.opacity(0.8))
                            .font(.subheadline)
                        
                        Text("Total meds: \(medicines.count)")
                            .foregroundColor(.black)
                        
                        Text("Taken: \(takenCount())   •   Due: \(dueCount())")
                            .foregroundColor(.black)
                        
                        Divider().padding(.vertical, 6)
                        
                        if medicines.isEmpty {
                            Text("No medicines added yet.")
                                .foregroundColor(.black.opacity(0.7))
                        } else {
                            ScrollView {
                                VStack(spacing: 10) {
                                    ForEach(medicines.indices, id: \.self) { i in
                                        medicineRow(index: i)
                                    }
                                }
                                .padding(.top, 4)
                            }
                            .frame(maxHeight: 260)
                        }
                        
                        Button("Reset Taken (New Day)") {
                            resetTaken()
                        }
                        .buttonStyle(.bordered)
                        .tint(.orange)
                        
                        Button("Back to Menu") {
                            section = .main
                        }
                        .buttonStyle(.bordered)
                    }
                }
            }
            .padding()
        }
    }
    
    func medicineRow(index: Int) -> some View {
        let med = medicines[index]
        return VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text("\(med.name)")
                    .font(.headline)
                    .foregroundColor(.black)
                
                Spacer()
                
                Text(med.time)
                    .foregroundColor(.black.opacity(0.8))
                    .font(.subheadline)
            }
            
            Text("Dosage: \(med.dosage)")
                .foregroundColor(.black.opacity(0.8))
                .font(.subheadline)
            
            HStack {
                Text(med.takenToday ? "Status: Taken ✅" : "Status: Due ⏰")
                    .foregroundColor(med.takenToday ? .green : .red)
                    .font(.subheadline)
                
                Spacer()
                
                Button(med.takenToday ? "Undo" : "Mark Taken") {
                    medicines[index].takenToday.toggle()
                }
                .buttonStyle(.borderedProminent)
                .tint(med.takenToday ? .gray : .green)
            }
        }
        .padding()
        .background(Color.black.opacity(0.05))
        .cornerRadius(12)
    }
    
    func takenCount() -> Int {
        medicines.filter { $0.takenToday }.count
    }
    
    func dueCount() -> Int {
        medicines.filter { !$0.takenToday }.count
    }
    
    func resetTaken() {
        for i in medicines.indices {
            medicines[i].takenToday = false
        }
    }
}
