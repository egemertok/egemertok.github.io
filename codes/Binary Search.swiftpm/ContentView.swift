import SwiftUI

struct ContentView: View {
    @State var output: [String] = []
    
    func binarySearch(list: [Int], target: Int) -> Int? {
        var left = 0
        var right = list.count - 1
        var step = 1
        
        output.append("Searching for \(target)")
        output.append("List: \(list)\n")
        
        while left <= right {
            let mid = (left + right) / 2
            let midValue = list[mid]
            
            output.append("Step \(step): left=\(left), right=\(right), mid=\(mid), value=\(midValue)")
            
            if midValue == target {
                output.append("Found at index \(mid)\n")
                return mid
            } else if target < midValue {
                output.append("Target is smaller, search left half\n")
                right = mid - 1
            } else {
                output.append("Target is larger, search right half\n")
                left = mid + 1
            }
            
            step += 1
        }
        
        output.append("Not found\n")
        return nil
    }
    
    var body: some View {
        VStack {
            Text("Binary Seach")
                .font(.title)
                .padding()
                .bold()
            
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(output, id: \.self) { line in
                        Text(line)
                            .font(.body)
                            .padding(.bottom, 4)
                    }
                }
                .padding()
            }
        }
        .onAppear {
            output = []
            let students = Array(1...25).shuffled().sorted()
            let targets = [students[5], students[10], 999] 
            
            for t in targets {
                _ = binarySearch(list: students, target: t)
            }
        }
    }
}



