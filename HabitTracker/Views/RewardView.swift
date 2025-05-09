//
//  RewardView.swift
//  HabitTracker
//
//  Created by Camilla Falk on 2025-05-05.
//

import SwiftUI

struct RewardView: View {
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        entity: Reward.entity(),
        sortDescriptors: [],
        animation: .default)
    
    private var rewardsCoreData: FetchedResults<Reward>
    
    var body: some View {
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .green]),
                           startPoint: .top,
                           endPoint: .bottom)
            .ignoresSafeArea()
            
            VStack{
                Text("Rewards")
                    .font(.system(size: 45))
                    .fontDesign(.monospaced)
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20){
                        
                        ForEach(rewardsCoreData) { reward in
                            HStack{
                                Text(reward.title ?? "Title")
                                Text(reward.emoji ?? "Emoji")
                            }
                            
                            .frame(width: 175, height: 75)
                            .contentShape(Rectangle())
                            .background(.green)
                            .clipShape(.rect(cornerRadius: 15))
                            .overlay(RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.black, lineWidth: 1))
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    RewardView()
}
