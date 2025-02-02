//
//  DifficultySelectionView.swift
//  Square Game
//
//  Created by sasiri rukshan nanayakkara on 1/26/25.
//

import SwiftUI

struct DifficultySelectionView: View {
    var gridSize: Int
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Select Difficulty Level")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            NavigationLink(destination: getGameView(difficulty: "Easy")) {
                Text("Easy")
                    .font(.title2)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }

            NavigationLink(destination: getGameView(difficulty: "Medium")) {
                Text("Medium")
                    .font(.title2)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }

            NavigationLink(destination: getGameView(difficulty: "Hard")) {
                Text("Hard")
                    .font(.title2)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
        }
    }
    
    @ViewBuilder
    func getGameView(difficulty: String) -> some View {
        switch gridSize {
        case 3:
            Grid3x3View(difficulty: difficulty)
        case 4:
            Grid4x4View()
        case 5:
            Grid5x5View()
        default:
            Grid3x3View(difficulty: difficulty) // Default case
        }
    }
}

