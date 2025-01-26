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
        .alert(isPresented: .constant(gameOver && selectedBoxes.count == 2)) {
            Alert(
                title: Text("Game Over"),
                message: Text("You lost the game!"),
                dismissButton: .default(Text("Restart"), action: {
                    saveHighScore()
                    totalScore = 0
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
        displayedColors[index] = color
        disabledBoxes.insert(index)

        if selectedBoxes.count == 2 {
            let firstBox = selectedBoxes[0]
            let secondBox = selectedBoxes[1]

            if firstBox.color == secondBox.color {
                // Correct match
                matchedPairs.insert(firstBox.index)
                matchedPairs.insert(secondBox.index)
                score += 1
                totalScore += 1
                displayedColors[firstBox.index] = firstBox.color.opacity(0.5)
                displayedColors[secondBox.index] = secondBox.color.opacity(0.5)

                if matchedPairs.count == 8 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        startNewGame()
                    }
                }
            } else {
                saveHighScore()
                gameOver = true
            }
            selectedBoxes.removeAll()
        }
    }

    func saveHighScore() {
        guard totalScore > 0 else { return }

        var highScores = UserDefaults.standard.getHighScores(forKey: "highScores")
        
        if !highScores.contains(totalScore) {
            highScores.append(totalScore)
            highScores.sort(by: >)

            if highScores.count > 10 {
                highScores = Array(highScores.prefix(10))
            }

            UserDefaults.standard.setHighScores(highScores, forKey: "highScores")
 
            print("High Score Saved: \(totalScore)")
        }
    }


}

#Preview {
    ContentView()
}










