//
//  GameOverOverlay.swift
//  Words
//
//  Created by Dasha Palshau on 19.10.2022.
//

import SwiftUI

struct GameOverOverlay: View {
    
    @StateObject var viewModel: GameOverViewModel
    @Binding var showOverlay: Bool
    @Binding var shouldReturnToGame: Bool
    
    var onDismiss: (() -> Void)?
    
    typealias StatNames = GameOverViewModel.StatName
    
    var body: some View {
        ZStack {
            Color(ThemeManager.shared.baseColor.cgColor!).opacity(1)
                .ignoresSafeArea()
            VStack {
                Spacer()
                RoundedRectangle(cornerRadius: 20).fill(Color(.systemBackground))
                    .padding()
                    .shadow(color: .black.opacity(0.4), radius: 2, x: 2, y: 2)
                    .overlay(
                        VStack {
                            Text("Time's up")
                                .font(.system(size: 36, weight: .semibold))
                                .padding()
                            
                            statRowView(title: "Score:", value: viewModel.newScore)
                            statRowView(title: "Words found:", value: viewModel.foundWords.count)
                            
                            if let bestScore = viewModel.statsDict[StatNames.bestScore.rawValue] {
                                statRowView(title: "\(StatNames.bestScore.rawValue):", value: Int(bestScore.value))
                            }
                            
                            if let mostFound = viewModel.statsDict[StatNames.mostWords.rawValue] {
                                statRowView(title: "\(StatNames.mostWords.rawValue):", value: Int(mostFound.value))
                            }

                            Spacer()
                            buttonsStack
                        }
                            .foregroundColor(ThemeManager.shared.textColor)
                            .padding()
                    )
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
                Spacer()
            }
        }
        .onAppear {
            viewModel.fetchStatistics()
        }
    }
    
    private var buttonsStack: some View {
        HStack {
            Button {
                shouldReturnToGame.toggle()
                withAnimation {
                    showOverlay.toggle()
                }
            } label: {
                Text("Exit")
                    .padding()
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(ThemeManager.shared.textColor)
                    .background {
                        Color(ThemeManager.shared.accentColor.cgColor!)
                            .cornerRadius(16)
                    }
            }

            
            Button {
                withAnimation {
                    showOverlay.toggle()
                }
                onDismiss?()
            } label: {
                Text("Play again")
                    .padding()
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(ThemeManager.shared.textColor)
                    .background {
                        Color(ThemeManager.shared.accentColor.cgColor!)
                            .cornerRadius(16)
                    }
            }
        }
        .padding()
    }
    
    private func statRowView(title: String, value: Int) -> some View {
        HStack {
            Text(title)
            Spacer()
            Text(String(value))
        }
        .font(.system(size: 24, weight: .medium))
        .padding(.horizontal)
        .padding(.bottom, 4)
    }
}

struct GameOverOverlay_Previews: PreviewProvider {
    static var previews: some View {
        let vm = GameOverViewModel(newScore: 44, foundWords: [])
        GameOverOverlay(viewModel: vm, showOverlay: .constant(false), shouldReturnToGame: .constant(true), onDismiss: nil)
    }
}
