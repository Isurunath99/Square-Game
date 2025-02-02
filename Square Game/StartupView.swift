//
//  StartupView.swift
//  Square Game
//
//  Created by sasiri rukshan nanayakkara on 1/19/25.
//

import SwiftUI

struct StartupView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Memory Game")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()

                NavigationLink(destination: GameModeSelectionView()) {
                    Text("Start Game")
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }


                NavigationLink(destination: HighScoresView()) {
                    Text("High Scores")
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }

                NavigationLink(destination: GuideView()) {
                    Text("Guide")
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
}

#Preview {
    StartupView()
}
