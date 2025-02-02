//
//  Grid5x5View.swift
//  Square Game
//
//  Created by sasiri rukshan nanayakkara on 2/2/25.
//

import SwiftUI

struct Grid5x5View: View {
    @State private var colors: [Color] = [.red, .red, .yellow, .yellow, .green, .green, .blue, .blue, .black, .black, .purple, .purple, .orange, .orange, .pink, .pink, .cyan, .cyan, .brown, .brown, .mint, .mint, .indigo, .indigo, .teal]
    @State private var shuffledColors: [Color] = []
    @State private var displayedColors: [Color] = Array(repeating: .gray, count: 25)
    @State private var selectedBoxes: [(index: Int, color: Color)] = []
    @State private var matchedPairs: Set<Int> = []
    @State private var disabledBoxes: Set<Int> = []
    @State private var score: Int = 0
    @State private var totalScore: Int = 0
    @State private var gameOver: Bool = false
    @State private var countdown: Int = 3

    var body: some View {
        VStack {
            Text("5x5 Memory Game")
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
            }

            Grid {
                ForEach(0..<5, id: \.self) { row in
                    GridRow {
                        ForEach(0..<5, id: \.self) { column in
                            let index = row * 5 + column
                            let isSelected = selectedBoxes.contains(where: { $0.index == index })
                            let isMatched = matchedPairs.contains(index)
                            let color = isMatched || isSelected ? shuffledColors[index] : displayedColors[index]
                            Rectangle()
                                .foregroundColor(color)
                                .frame(height: 70)
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
        score = 0
        gameOver = false
        countdown = 3

        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if countdown > 0 {
                countdown -= 1
            } else {
                timer.invalidate()
                displayedColors = Array(repeating: .gray, count: 25)
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
                score += 1
                totalScore += 1
            } else {
                gameOver = true
            }
            selectedBoxes.removeAll()
        }
    }
}

#Preview {
    Grid5x5View()
}
