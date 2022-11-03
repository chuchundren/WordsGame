//
//  StartView.swift
//  Words
//
//  Created by Dasha Palshau on 02.11.2022.
//

import SwiftUI

struct StartView: View {
    @State private var showingSheet = false
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                Button {
                    showingSheet.toggle()
                } label: {
                    Image(systemName: "crown.fill")
                        .resizable()
                        .tint(ThemeManager.shared.textColor)
                        .aspectRatio(contentMode: .fit)
                }
                .frame(width: 32, height: 32, alignment: .center)
                .padding()
            }
            
            Spacer()

        }
        
        .sheet(isPresented: $showingSheet) {
            StatisticsView(viewModel: StatisticsViewModel())
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
