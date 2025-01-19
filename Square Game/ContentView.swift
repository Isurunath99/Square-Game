//
//  ContentView.swift
//  Square Game
//
//  Created by isurunath nanayakkara on 1/4/25.
//

import SwiftUI

struct ContentView: View {
    @State private var colors: [Color] = [.red, .red, .yellow, .yellow, .green, .green, .blue, .blue, .black]
    @State private var shuffledColors: [Color] = []
    @State private var displayedColors: [Color] = Array(repeating: .gray, count: 9)
    @State private var selectedBoxes: [(index: Int, color: Color)] = []
    @State private var matchedPairs: Set<Int> = []
    @State private var disabledBoxes: Set<Int> = []
    @State private var score: Int = 0
    @State private var totalScore: Int = 0
    @State private var gameOver: Bool = false
    @State private var countdown: Int = 3

    var body: some View {
        VStack {
            Text("Memory Game")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 10)

            Text("Score: \(totalScore)")
                .font(.title)
                .padding()

            if countdown > 0 {
                Text("You have \(countdown) seconds of time remaining to memorize the colors")
                    .foregroundColor(.red)
                    .font(.headline)
                    .padding()
            }

            if !shuffledColors.isEmpty {
                            Grid(alignment: .center, horizontalSpacing: 10, verticalSpacing: 10) {
                                ForEach(0..<3, id: \ .self) { row in
                                    GridRow {
                                        ForEach(0..<3, id: \ .self) { column in
                                            let index = row * 3 + column
                                            let isSelected = selectedBoxes.contains(where: { $0.index == index })
                                            let isMatched = matchedPairs.contains(index)
                                            let color = isMatched || isSelected ? shuffledColors[index] : displayedColors[index]
                                            Rectangle()
                                                .foregroundColor(color)
                                                .frame(height: 100)
                                                .cornerRadius(10)
                                                .overlay(
                                                    Button(action: {
                                                        handleBoxTap(index: index)
                                                    }) {
                                                        Color.clear
                                                    }
                                                    .disabled(disabledBoxes.contains(index) || selectedBoxes.count == 2)
                                                )
                                        }
                                    }
                                }
                            }
                            .padding()
                        }

            if gameOver {
                Button("Restart Game") {
                    totalScore = 0 // Reset total score on game restart
                    startNewGame()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
        .onAppear(perform: startNewGame)
        .alert(isPresented: .constant(gameOver && selectedBoxes.count == 2)) {
            Alert(
                title: Text("Game Over"),
                message: Text("You lost the game!"),
                dismissButton: .default(Text("Restart"), action: {
                    saveHighScore()
                    totalScore = 0 // Reset total score on game restart
                    startNewGame()
                })
            )
        }
    }

    func startNewGame() {
        shuffledColors = colors.shuffled()
        displayedColors = shuffledColors
        selectedBoxes.removeAll()
        matchedPairs.removeAll()
        disabledBoxes.removeAll()
        score = 0
        gameOver = false
        countdown = 3

        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if countdown > 0 {
                countdown -= 1
            } else {
                timer.invalidate()
                displayedColors = Array(repeating: .gray, count: 9)
            }
        }
    }

    func handleBoxTap(index: Int) {
        guard !disabledBoxes.contains(index) else { return }
        let color = shuffledColors[index]
        selectedBoxes.append((index, color))
        displayedColors[index] = color // Show the color of the clicked square
        disabledBoxes.insert(index)

        if selectedBoxes.count == 2 {
            let firstBox = selectedBoxes[0]
            let secondBox = selectedBoxes[1]

            if firstBox.color == secondBox.color {
                // Correct match
                matchedPairs.insert(firstBox.index)
                matchedPairs.insert(secondBox.index)
                score += 1
                totalScore += 1 // Increment total score immediately on correct match
                displayedColors[firstBox.index] = firstBox.color.opacity(0.5)
                displayedColors[secondBox.index] = secondBox.color.opacity(0.5)

                if matchedPairs.count == 8 { // Only black box left
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        startNewGame()
                    }
                }
            } else {
                // Incorrect match
                saveHighScore() // Save the current score on wrong pair
                gameOver = true
            }
            selectedBoxes.removeAll()
        }
    }

    func saveHighScore() {
        guard totalScore > 0 else { return } // Save only if score is greater than 0

        // Retrieve current high scores
        var highScores = UserDefaults.standard.getHighScores(forKey: "highScores")
        
        // Check if the score already exists to avoid duplicates
        if !highScores.contains(totalScore) {
            highScores.append(totalScore)
            highScores.sort(by: >) // Sort scores in descending order

            // Keep only the top 10 scores
            if highScores.count > 10 {
                highScores = Array(highScores.prefix(10))
            }

            // Save the updated scores to UserDefaults
            UserDefaults.standard.setHighScores(highScores, forKey: "highScores")
            
            // Debugging print
            print("High Score Saved: \(totalScore)")
        }
    }


}

#Preview {
    ContentView()
}










