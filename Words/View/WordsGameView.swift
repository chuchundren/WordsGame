//
//  WordsGameView.swift
//  Words
//
//  Created by Dasha Palshau on 02.07.2022.
//

import SwiftUI

struct Location {
    let row: Int
    let col: Int
    let frame: CGRect
}

struct WordsGameView: View {
    @ObservedObject var game: WordsViewModel
    @State private var locations = [Location]()
    @State private var timeRemaining = Constants.defaultTime
    @State private var showOverlay = false
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            VStack {
                header
                
                Spacer()
                
                wordsGrid
                
                Spacer()
            }
            .background(ThemeManager.shared.background)
            
            if showOverlay {
                GameOverOverlay(score: game.scoreValue, showOverlay: $showOverlay, onDismiss: startNewGame)
                    .zIndex(1)
            }
        }
    }
    
    private var header: some View {
        HStack {
            Text("\(game.score)")
                .font(.system(size: 24, weight: .medium))
            Spacer()
            
            Text("\(game.formattedTime(from: timeRemaining))")
                .font(.system(size: 28, weight: .medium))
                .onReceive(timer) { _ in
                    if timeRemaining > 0 {
                        timeRemaining -= 1
                    } else {
                        timer.upstream.connect().cancel()
                        
                        withAnimation {
                            showOverlay.toggle()
                        }
                    }
                }
            
            Spacer()
            
            Button {
                game.startNewGame()
                timeRemaining = Constants.defaultTime
            } label: {
                Text("New game")
                    .font(.system(size: 20, weight: .medium))
            }
        }
        .foregroundColor(ThemeManager.shared.textColor)
        .padding()
    }
    
    private var wordsGrid: some View {
        VStack {
            Text(game.enteredWord)
                .foregroundColor(ThemeManager.shared.textColor)
                .font(.system(size: 40, weight: .semibold))
                .frame(width: UIScreen.main.bounds.width, height: 44, alignment: .center)
            VStack(alignment: .center) {
                ForEach(0..<game.grid.count, id: \.self) { row in
                    HStack {
                        ForEach(game.grid[row]) { item in
                            LetterView(letter: item)
                                .background(self.rectReader(row: item.row, col: item.col))
                        }
                    }
                }
            }
            .gesture(dragGesture)
            .padding()
        }
    }
    
    private var dragGesture: some Gesture {
        DragGesture(minimumDistance: 0, coordinateSpace: .global)
            .onChanged { value in
                if let index = locations.firstIndex(where: { location in
                    location.frame.contains(value.location)
                }) {
                    game.selectLetter(row: locations[index].row, col: locations[index].col)
                }
            }
            .onEnded { _ in
                game.enterWord()
            }
    }
    
    // MARK: Functions
    
    private func startNewGame() {
        game.startNewGame()
        timeRemaining = Constants.defaultTime
        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    }
    
    
    private func rectReader(row: Int, col: Int) -> some View {
        return GeometryReader { (geometry) -> AnyView in
            DispatchQueue.main.async {
                self.locations.append(Location(row: row, col: col, frame:
                                        geometry.frame(in: .global)))
            }
            
            return AnyView(Rectangle().fill(Color.clear))
        }
    }
    
    // MARK: - Constants
    
    private enum Constants {
        static let defaultTime: TimeInterval = 120
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WordsGameView(game: WordsViewModel())
    }
}

