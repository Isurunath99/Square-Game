//
//  HighScoresView.swift
//  Square Game
//
//  Created by sasiri rukshan nanayakkara on 1/19/25.
//

import SwiftUI

struct HighScoresView: View {
    @State private var highScores: [Int] = []

    var body: some View {
        VStack {
            Text("High scores so far !!!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            if highScores.isEmpty {
                Text("No high scores yet!")
                    .font(.title3)
                    .foregroundColor(.gray)
                    .padding()
            } else {
                List(highScores, id: \.self) { score in
                    Text("Score: \(score)")
                        .font(.title3)
                }
            }

            Spacer()
        }
        .onAppear {
            highScores = UserDefaults.standard.getHighScores(forKey: "highScores")
            print("High Scores Loaded: \(highScores)") 
        }
        .padding()
    }
}



#Preview {
    HighScoresView()
}
