import SwiftUI

struct ContentView: View {
    var body: some View {
        BinaryCounterView()
    }
}

#Preview {
    ContentView()
}

struct BinaryCounterView: View {
    @State private var id: Int = 0
    @State private var bitCount: Int = 4
    @State private var showOverflow = false
    
    private var maxID: Int { (1 << bitCount) - 1 }
    private var modulus: Int { 1 << bitCount }
    private var weights: [Int] { (0..<bitCount).map { 1 << $0 }.reversed() }
    private var paddedBinary: String {
        let raw = String(id, radix: 2)
        let pad = String(repeating: "0", count: max(0, bitCount - raw.count))
        return pad + raw
    }
    
    private func enrollPlusOne() {
        showOverflow = (id == maxID)
        id = (id + 1) % modulus
    }
    
    private func reset() {
        id = 0
        showOverflow = false
    }
    
    private func setPreset(_ value: Int) {
        id = min(max(0, value), maxID)
        showOverflow = false
    }
    
    private func changeBitCount(to newCount: Int) {
        bitCount = newCount
        id = id % (1 << newCount)
        showOverflow = false
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Picker("Bit Width", selection: Binding(
                get: { bitCount },
                set: { changeBitCount(to: $0) }
            )) {
                Text("4-bit").tag(4)
                Text("5-bit").tag(5)
            }
            .pickerStyle(.segmented)
            .frame(maxWidth: 260)
            
            Text("\(bitCount)-Bit Binary Counter")
                .font(.title.bold())
            
            VStack(spacing: 4) {
                Text("Decimal: \(id)")
                    .font(.title3.monospacedDigit())
                Text("Binary: \(paddedBinary)")
                    .font(.title3.monospacedDigit())
            }
            
            if showOverflow {
                Text("OVERFLOW!")
                    .font(.headline)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(.red.opacity(0.2))
                    .clipShape(Capsule())
            }
            
            HStack(spacing: 10) {
                ForEach(weights, id: \.self) { weight in
                    let isOne = (id & weight) != 0
                    RoundedRectangle(cornerRadius: 10)
                        .fill(isOne ? .green : .gray.opacity(0.35))
                        .frame(width: 50, height: 50)
                        .overlay(
                            Text(isOne ? "1" : "0")
                                .font(.title3.bold())
                        )
                }
            }
            
            HStack(spacing: 12) {
                Button("Enroll (+1)", action: enrollPlusOne)
                    .buttonStyle(.borderedProminent)
                Button("Reset (0)", action: reset)
                    .buttonStyle(.bordered)
            }
            
            VStack(spacing: 8) {
                Text("Presets:")
                    .font(.subheadline)
                HStack(spacing: 10) {
                    Button("Set ID = 7") { setPreset(7) }
                    Button("Set ID = 10") { setPreset(10) }
                    Button("Set ID = \(maxID)") { setPreset(maxID) }
                }
                .buttonStyle(.bordered)
            }
            
            Spacer()
        }
        .padding()
    }
}












