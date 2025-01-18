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
    @State private var selectedBoxes: [(index: Int, color: Color)] = []
    @State private var matchedPairs: Set<Int> = []
    @State private var disabledBoxes: Set<Int> = []
    @State private var score: Int = 0
    @State private var totalScore: Int = 0
    @State private var gameOver: Bool = false

    var body: some View {
        VStack {
            Text("Score: \(totalScore)")
                .font(.largeTitle)
                .padding()

            if !shuffledColors.isEmpty {
                Grid(alignment: .center, horizontalSpacing: 10, verticalSpacing: 10) {
                    ForEach(0..<3, id: \ .self) { row in
                        GridRow {
                            ForEach(0..<3, id: \ .self) { column in
                                let index = row * 3 + column
                                let isSelected = selectedBoxes.contains(where: { $0.index == index })
                                let isMatched = matchedPairs.contains(index)
                                let color = shuffledColors[index]
                                Rectangle()
                                    .foregroundColor(isMatched || isSelected ? color.opacity(0.5) : color)
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
                    totalScore = 0 // Reset total score on game restart
                    startNewGame()
                })
            )
        }
    }

    func startNewGame() {
        shuffledColors = colors.shuffled() // Properly initialize here
        selectedBoxes.removeAll()
        matchedPairs.removeAll()
        disabledBoxes.removeAll()
        score = 0
        gameOver = false
    }

    func handleBoxTap(index: Int) {
        guard !disabledBoxes.contains(index) else { return }
        let color = shuffledColors[index]
        selectedBoxes.append((index, color))
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
                if matchedPairs.count == 8 { // Only black box left
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        startNewGame()
                    }
                }
            } else {
                gameOver = true
            }
            selectedBoxes.removeAll()
        }
    }
}

#Preview {
    ContentView()
}







