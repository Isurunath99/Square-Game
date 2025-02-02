//
//  GameModeSelectionView.swift
//  Square Game
//
//  Created by sasiri rukshan nanayakkara on 2/1/25.
//

import SwiftUI

struct GameModeSelectionView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Select Game Mode")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            NavigationLink(destination: DifficultySelectionView(gridSize: 3)) {
                Text("3x3 Mode")
                    .font(.title2)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }

            NavigationLink(destination: DifficultySelectionView(gridSize: 4)) {
                Text("4x4 Mode")
                    .font(.title2)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }

            NavigationLink(destination: DifficultySelectionView(gridSize: 5)) {
                Text("5x5 Mode")
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
}

