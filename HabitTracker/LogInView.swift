//
//  LogInView.swift
//  HabitTracker
//
//  Created by Camilla Falk on 2025-04-29.
//

import SwiftUI

struct LogInView: View {
   
    @State var username : String = ""
    @State var password : String = ""
    
    @Environment(\.dismiss) var dismiss
        
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
                    Spacer()
                    Text("Log in")
                        .font(.title)
                        .fontDesign(.monospaced)
                    
                    
                    VStack(alignment: .leading, spacing: 15){
                        
                        Text("Username")
                            .fontDesign(.monospaced)
                        
                        TextField("Username", text: $username)
                            .customStyleTextFields()
                        
                        Text("Password")
                            .fontDesign(.monospaced)
                        
                        SecureField("Password", text: $password)
                            .customStyleTextFields()
                        
                        HStack {
                            Spacer()
                            Button("Sign in") {
                                
                            }
                            .customStyleButton()
                            
                            Spacer()
                        }
                    }
                }.padding()
            }
            .toolbar() {
                ToolbarItem(placement: .cancellationAction){
                    Button("Back"){
                        dismiss()
                    }
                    .fontDesign(.monospaced)
                    .foregroundStyle(.black)
                }
            }
        }
    }
}

#Preview {
    LogInView()
}
