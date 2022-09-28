//
//  WordsApp.swift
//  Words
//
//  Created by Dasha Palshau on 02.07.2022.
//

import SwiftUI

@main
struct WordsApp: App {
    var body: some Scene {
        WindowGroup {
            WordsGameView(game: WordsViewModel())
        }
    }
}
