//
//  GuideView.swift
//  Square Game
//
//  Created by sasiri rukshan nanayakkara on 1/19/25.
//

import SwiftUI

struct GuideView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("How to Play")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 10)

            Text("1. Memorize the colors and their positions within the given time.")
            Text("2. Click on two squares to match their colors.")
            Text("3. Match all pairs correctly to win.")
            Text("4. The game will restart automatically after completing all matches.")
            Text("5. If you click on two wrong squares, the game will end.")

            Spacer()
        }
        .padding()
    }
}
