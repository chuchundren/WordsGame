//
//  GameOverOverlay.swift
//  Words
//
//  Created by Dasha Palshau on 19.10.2022.
//

import SwiftUI

struct GameOverOverlay: View {
    private(set) var score: Int
    @Binding var showOverlay: Bool
    @Binding var shouldReturnToGame: Bool
    var onDismiss: (() -> Void)?
    
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
                            Spacer()
                            Text("Time's up")
                                .font(.system(size: 40, weight: .semibold))
                            Text("Your score is")
                                .font(.system(size: 17, weight: .regular))
                            Text("\(score)")
                                .font(.system(size: 40, weight: .bold))
                            
                            Spacer()
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
                                    Text("Try again")
                                        .padding()
                                        .font(.system(size: 20, weight: .semibold))
                                        .foregroundColor(ThemeManager.shared.textColor)
                                        .background {
                                            Color(ThemeManager.shared.accentColor.cgColor!)
                                                .cornerRadius(16)
                                        }
                                }
                            }
                            
                            Spacer()
                        }
                            .foregroundColor(ThemeManager.shared.textColor)
                            .padding()
                    )
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
                Spacer()
            }
        }
    }
}

struct GameOverOverlay_Previews: PreviewProvider {
    static var previews: some View {
        GameOverOverlay(score: 54, showOverlay: .constant(false), shouldReturnToGame: .constant(true), onDismiss: nil)
    }
}
