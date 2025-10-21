import SwiftUI


func initialTimeForLevel(level: Int) -> Int {
    if level == 1 { return 20 }
    else if level == 2 { return 18 }
    else if level == 3 { return 16 }
    else if level == 4 { return 14 }
    else { return 8 }
}

struct Obstacle: Identifiable {
    let id = UUID()
    var x: CGFloat
    var y: CGFloat
    var w: CGFloat
    var h: CGFloat
    var speed: CGFloat
}

struct ContentView: View {

    private let W: CGFloat = 320
    private let H: CGFloat = 440
    

    @State private var level = 1
    @State private var lives = 3
    @State private var time = 20
    @State private var timeMax = 20
    @State private var running = false
    

    @State private var px: CGFloat = 0
    @State private var py: CGFloat = 160
    private let step: CGFloat = 24
    private let pSize: CGFloat = 32
    

    @State private var obstacles: [Obstacle] = []
    

    private let tick = Timer.publish(every: 0.02, on: .main, in: .common).autoconnect()
    @State private var secAcc: Double = 0
    
    var body: some View {
        VStack(spacing: 16) {
            
            // Analog clock
            AnalogClock(secondsLeft: time, secondsMax: timeMax)
                .frame(width: 160, height: 160)
            
            // Top row: level + lives text
            HStack {
                Text("Level \(level)").font(.title3).bold()
                Spacer()
                Text("Lives \(lives)/3").font(.title3).monospacedDigit()
            }
            .frame(width: W)
            
            // Game board
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .strokeBorder(.gray.opacity(0.6), lineWidth: 3)
                    .frame(width: W+12, height: H+12)
                
                ZStack(alignment: .top) {
                    Rectangle()
                        .fill(Color.black.opacity(0.88))
                        .frame(width: W, height: H)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                    // Goal bar (reach this)
                    Rectangle()
                        .fill(Color.green.opacity(0.85))
                        .frame(width: W - 24, height: 36)
                        .padding(.top, 8)
                    
                    // Obstacles
                    ForEach(obstacles) { ob in
                        Rectangle()
                            .fill(Color.orange)
                            .frame(width: ob.w, height: ob.h)
                            .position(x: (W/2) + ob.x,
                                      y: (H/2) + ob.y)
                    }
                    
                    // Player
                    Circle()
                        .fill(Color.blue)
                        .frame(width: pSize, height: pSize)
                        .position(x: (W/2) + px,
                                  y: (H/2) + py)
                }
            }
            
            // Controls
            HStack(spacing: 20) {
                Button(action: { move(dx: -step, dy: 0) }) { control("←") }
                Button(action: { move(dx: 0, dy: -step) }) { control("↑") }
                Button(action: { move(dx: 0, dy: step) }) { control("↓") }
                Button(action: { move(dx: step, dy: 0) }) { control("→") }
            }
            
            Button(action: { startFromLevelOne() }) {
                Text(running ? "Restart" : "Start / Restart")
                    .font(.title3.bold())
            }
            .buttonStyle(.borderedProminent)
            .tint(.green)
        }
        .padding()
        .onAppear { setupScreen() }
        .onReceive(tick) { _ in
            guard running else { return }
            update(dt: 0.02)
        }
    }
    
    // MARK: - Small helpers
    
    private func control(_ s: String) -> some View {
        Text(s)
            .font(.title2.bold())
            .frame(width: 56, height: 44)
            .background(Color.orange)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
    private func setupScreen() {
        level = 1
        lives = 3
        timeMax = initialTimeForLevel(level: level)
        time = timeMax
        running = false
        resetPlayer()
        spawn(level)
    }
    
    private func startFromLevelOne() {
        level = 1
        lives = 3
        startLevel()
    }
    
    private func startLevel() {
        timeMax = initialTimeForLevel(level: level)
        time = timeMax
        secAcc = 0
        resetPlayer()
        spawn(level)
        running = true
    }
    
    private func nextLevel() {
        level += 1
        startLevel()
    }
    
    private func loseLifeAndRetry() {
        lives -= 1
        if lives <= 0 {
            level = 1
            lives = 3
        }
        startLevel()
    }
    
    private func resetPlayer() {
        px = 0
        py = (H/2) - (pSize/2) - 24
    }
    
    // MARK: - Mechanics
    
    private func spawn(_ level: Int) {
        let v: CGFloat = 1.2 + CGFloat(level) * 0.45
        obstacles = [
            Obstacle(x: W/2 + 40, y: -40, w: 90, h: 28, speed: v),
            Obstacle(x: W/2 + 10, y:  40, w: 80, h: 28, speed: v * 0.95),
            Obstacle(x: W/2 + 80, y: 100, w: 90, h: 28, speed: v * 1.10)
        ]
    }
    
    private func update(dt: Double) {
        // Move obstacles R→L; wrap
        for i in obstacles.indices {
            obstacles[i].x -= obstacles[i].speed
            if obstacles[i].x < -(W/2) - 60 {
                obstacles[i].x = (W/2) + 60
                obstacles[i].y = [-40, 40, 100].randomElement()!
            }
        }
        
        // Countdown seconds
        secAcc += dt
        if secAcc >= 1 {
            secAcc -= 1
            time -= 1
            if time <= 0 { loseLifeAndRetry(); return }
        }
        
        // Win: reach green bar
        let goalY = -(H/2) + 26 // center of the green bar
        if py <= goalY { nextLevel(); return }
        
        let p = CGRect(x: px - pSize/2, y: py - pSize/2, width: pSize, height: pSize)
        for ob in obstacles {
            let r = CGRect(x: ob.x - ob.w/2, y: ob.y - ob.h/2, width: ob.w, height: ob.h)
            if p.intersects(r) { loseLifeAndRetry(); break }
        }
    }
    
    private func move(dx: CGFloat, dy: CGFloat) {
        guard running else { return }
        px = (px + dx).clamped(to: -(W/2 - pSize/2 - 6)...(W/2 - pSize/2 - 6))
        py = (py + dy).clamped(to: -(H/2 - pSize/2 - 6)...(H/2 - pSize/2 - 6))
    }
}

struct AnalogClock: View {
    let secondsLeft: Int
    let secondsMax: Int
    
    private var progress: Double {
        guard secondsMax > 0 else { return 0 }
        return Double(secondsLeft) / Double(secondsMax) // 1 → 0
    }
    
    var body: some View {
        ZStack {
            Circle().stroke(lineWidth: 10).foregroundStyle(.gray.opacity(0.4))
            Capsule()
                .fill(Color.red)
                .frame(width: 4, height: 60)
                .offset(y: -30)
                .rotationEffect(.degrees(360 * (1 - progress)))
                .animation(.linear(duration: 0.02), value: secondsLeft)
            Circle().fill(Color.primary).frame(width: 6, height: 6)
            Text("\(secondsLeft)s").font(.headline.monospacedDigit()).offset(y: 58)
        }
    }
}

fileprivate extension Comparable {
    func clamped(to range: ClosedRange<Self>) -> Self {
        min(max(self, range.lowerBound), range.upperBound)
    }
}



