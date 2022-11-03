//
//  StatisticsView.swift
//  Words
//
//  Created by Dasha Palshau on 02.11.2022.
//

import SwiftUI

struct StatisticsView: View {
    
    @ObservedObject var viewModel: StatisticsViewModel
    
    typealias StatNames = GameOverViewModel.StatName
    
    var body: some View {
        VStack {
            Text("Statistics")
                .font(Font.system(size: 32, weight: .semibold))
                .foregroundColor(ThemeManager.shared.textColor)
                .padding()
            
            statsRows
            .font(Font.system(size: 22, weight: .semibold))
            .foregroundColor(ThemeManager.shared.textColor)
            .padding([.leading, .trailing], 16)
            
            Spacer()
        }
        .onAppear {
            viewModel.fetchStatistics()
        }
        
    }
    
    private var statsRows: some View {
        VStack(alignment: .leading, spacing: 16) {
            statRow(for: .bestScore)
            statRow(for: .mostWords)
            statRow(for: .maxWordLenght)
            statRow(for: .totalGames)
        }
    }
    
    private func statRow(for statistic: StatNames) -> some View {
        HStack{
            Text("\(statistic.rawValue):")
            Spacer()
            
            if let totalPlayed = viewModel.statsDict[statistic.rawValue] {
                Text("\(totalPlayed.value)")
            }
        }
    }
    
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView(viewModel: StatisticsViewModel())
    }
}
