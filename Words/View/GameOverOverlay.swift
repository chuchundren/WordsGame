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
    var onDismiss: (() -> Void)?
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Color(.systemBackground).opacity(0)
                .ignoresSafeArea()
            VStack {
                Spacer()
                RoundedRectangle(cornerRadius: 20).fill(Color(.systemBackground))
                    .padding()
                    .shadow(color: .black.opacity(0.4), radius: 2, x: 2, y: 2)
                    .overlay(
                        VStack {
                            Text("Time's up")
                            Text("Your score is")
                            Text("\(score)")
                            
                            Button {
                                withAnimation {
                                    showOverlay.toggle()
                                }
                                onDismiss?()
                            } label: {
                                Text("Try again")
                            }
                        }
                    )
                    .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.width * 0.9)
                Spacer()
            }
        }
    }
}

struct GameOverOverlay_Previews: PreviewProvider {
    static var previews: some View {
        GameOverOverlay(score: 54, showOverlay: .constant(false), onDismiss: nil)
    }
}
