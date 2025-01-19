//
//  UserDefaults.swift
//  Square Game
//
//  Created by sasiri rukshan nanayakkara on 1/19/25.
//

import Foundation

extension UserDefaults {
    func getHighScores(forKey key: String) -> [Int] {
        return array(forKey: key) as? [Int] ?? []
    }

    func setHighScores(_ scores: [Int], forKey key: String) {
        set(scores, forKey: key)
    }
}

