//
//  GuideView.swift
//  Square Game
//
//  Created by sasiri rukshan nanayakkara on 1/19/25.
//

import SwiftUI

struct GuideView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                Text("Memory Game Guide")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 10)

                Group {
                    Text("Introduction")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Text("Memory Game is a fun and engaging way to test and improve your memory skills. Your task is to memorize the colors displayed on a grid and match pairs of squares based on their colors.")
                }

                Group {
                    Text("How to Play")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Text("1. When the game starts, you will see a grid of squares, each with a different color. You have 3 seconds to memorize the positions of the colors.")
                    Text("2. After 3 seconds, the squares will turn gray. You must then click on two squares to reveal their colors.")
                    Text("3. If the colors match, the squares will remain highlighted, and you earn a point.")
                    Text("4. If the colors do not match, the game will end, and your score will be saved if it is greater than zero.")
                    Text("5. Match all pairs to win the game. The game will restart automatically once completed.")
                }

                Group {
                    Text("Scoring System")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Text("- You earn 1 point for every correct match.")
                    Text("- Your high scores are saved automatically if they are unique and above 0.")
                }

                Group {
                    Text("Strategies for Success")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Text("1. Pay close attention during the 3-second memorization phase.")
                    Text("2. Focus on the position of colors rather than their shape or size.")
                    Text("3. Use a systematic approach to reveal squares, such as starting from the top left and working row by row.")
                    Text("4. Practice regularly to improve your memory and recognition speed.")
                }

                Group {
                    Text("Features")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Text("- 3-second preview time for colors.")
                    Text("- Score tracking and high scores display.")
                    Text("- Guide page with detailed instructions.")
                    Text("- Restart button to reset the game at any point.")
                }

                Group {
                    Text("Enjoy the Game!")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Text("We hope you have a great time playing Memory Game. Challenge yourself and aim for the highest score!")
                }
            }
            .padding()
        }
    }
}
