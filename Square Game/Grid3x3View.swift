//
//  ContentView.swift
//  Square Game
//
//  Created by isurunath nanayakkara on 1/4/25.
//

import SwiftUI

struct Grid3x3View: View {
    var difficulty: String
    
    @State private var colors: [Color] = [.red, .red, .yellow, .yellow, .green, .green, .blue, .blue, .black]
    @State private var shuffledColors: [Color] = []
    @State private var displayedColors: [Color] = Array(repeating: .gray, count: 9)
    @State private var selectedBoxes: [(index: Int, color: Color)] = []
    @State private var matchedPairs: Set<Int> = []
    @State private var disabledBoxes: Set<Int> = []
    @State private var totalScore: Int = 0
    @State private var gameOver: Bool = false
    @State private var countdown: Int = 3
    @State private var selectionTimer: Int = 8
    @State private var timerActive = false
    @State private var selectionTimerObject: Timer?
    
    var body: some View {
        VStack {
            Text("3x3 Memory Game (\(difficulty) Mode)")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 10)

            Text("Score: \(totalScore)")
                .font(.title)
                .padding()

            if countdown > 0 {
                Text("Memorize the colors: \(countdown) seconds left")
                    .foregroundColor(.red)
                    .font(.headline)
                    .padding()
            } else if timerActive {
                Text("Time left to select: \(selectionTimer) seconds")
                    .foregroundColor(.red)
                    .font(.headline)
                    .padding()
            }

            Grid {
                ForEach(0..<3, id: \.self) { row in
                    GridRow {
                        ForEach(0..<3, id: \.self) { column in
                            let index = row * 3 + column
                            let isSelected = selectedBoxes.contains(where: { $0.index == index })
                            let isMatched = matchedPairs.contains(index)
                            let color = isMatched || isSelected ? shuffledColors[index] : displayedColors[index]
                            Rectangle()
                                .foregroundColor(color)
                                .frame(height: 100)
                                .cornerRadius(10)
                                .onTapGesture {
                                    handleBoxTap(index: index)
                                }
                        }
                    }
                }
            }
            .padding()
            
            if gameOver {
                Button("Restart Game") {
                    totalScore = 0
                    startNewGame()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
        .onAppear(perform: startNewGame)
    }

    func startNewGame() {
        shuffledColors = colors.shuffled()
        displayedColors = shuffledColors
        selectedBoxes.removeAll()
        matchedPairs.removeAll()
        disabledBoxes.removeAll()
        gameOver = false
        countdown = 3
        timerActive = false

        // Set timer based on difficulty
        switch difficulty {
        case "Easy": selectionTimer = 8
        case "Medium": selectionTimer = 7
        case "Hard": selectionTimer = 6
        default: selectionTimer = 8
        }

        // Countdown timer before hiding colors
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if countdown > 0 {
                countdown -= 1
            } else {
                timer.invalidate()
                displayedColors = Array(repeating: .gray, count: 9)
                startSelectionTimer()
            }
        }
    }

    func startSelectionTimer() {
        timerActive = true
        selectionTimerObject?.invalidate() // Stop any existing timer before starting a new one

        selectionTimerObject = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if selectionTimer > 0 {
                selectionTimer -= 1
            } else {
                timer.invalidate()
                gameOver = true
            }
        }
    }

    func handleBoxTap(index: Int) {
        guard !disabledBoxes.contains(index) else { return }
        let color = shuffledColors[index]
        selectedBoxes.append((index, color))
        displayedColors[index] = color
        disabledBoxes.insert(index)

        if selectedBoxes.count == 2 {
            let firstBox = selectedBoxes[0]
            let secondBox = selectedBoxes[1]

            if firstBox.color == secondBox.color {
                matchedPairs.insert(firstBox.index)
                matchedPairs.insert(secondBox.index)
                totalScore += 1

                if matchedPairs.count == 8 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        startNewGame()
                    }
                } else {
                    selectionTimerObject?.invalidate() // Reset timer on correct selection
                    startSelectionTimer()
                }
            } else {
                gameOver = true
            }
            selectedBoxes.removeAll()
        }
    }
}

#Preview {
    Grid3x3View(difficulty: "Easy")
}
