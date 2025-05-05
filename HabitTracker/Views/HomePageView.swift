//
//  HomePageView.swift
//  HabitTracker
//
//  Created by Camilla Falk on 2025-04-29.
//

import SwiftUI

struct HomePageView: View {
    
    @AppStorage("isLoggedIn") var isLoggedIn = true
    
    var body: some View {
        
        if isLoggedIn {
            TabView{
                
                ContentView()
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }
                
                ProgressView()
                    .tabItem {
                        Image(systemName: "align.vertical.bottom.fill")
                        Text("Progress")
                    }
                
                RewardView()
                    .tabItem {
                        Image(systemName: "trophy")
                        Text("Rewards")
                    }
            }
            .tint(.indigo)
        } else {
            
            NavigationStack {
                
                ZStack{
                    LinearGradient(gradient: Gradient(colors: [.blue, .green]),
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
                            
                            NavigationLink(destination: LogInView()) {
                                Text("Log in")
                                    .customStyleButton()
                            }
                            
                            Spacer()
                            
                            NavigationLink(destination: CreateAccountView()) {
                                Text("Sign up")
                                    .customStyleButton()
                            }
                            
                            Spacer()
                            
                        }
                        Spacer()
                    }
                }
            }
            .tint(.black)
        }
    }
}

#Preview {
    HomePageView()
}
