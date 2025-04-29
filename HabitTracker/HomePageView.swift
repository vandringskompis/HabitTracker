//
//  HomePageView.swift
//  HabitTracker
//
//  Created by Camilla Falk on 2025-04-29.
//

import SwiftUI

struct HomePageView: View {
    var body: some View {
        NavigationStack {
            ZStack{
                LinearGradient(gradient: Gradient(colors: [.red, .green]),
                               startPoint: .top,
                               endPoint: .bottom)
                .ignoresSafeArea()
                
                VStack{
                    
                    Spacer()
                    
                    Text("HabitTracker")
                        .font(.system(size: 45))
                        .fontDesign(.monospaced)
                     .shadow(radius: 10.0, x: 20, y: 10)
                   
                    Spacer()
                    
                    customIcons()
                    
                    Spacer()
            
                        HStack{
                                
                                Spacer()
                               
                                Button("Log in"){
                                    
                                }
                                .customStyleButton()
                                
                                Spacer()
                                
                                Button("Sign up"){
                                    
                                }
                                .customStyleButton()
                            
                                Spacer()
                            }
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    HomePageView()
}
