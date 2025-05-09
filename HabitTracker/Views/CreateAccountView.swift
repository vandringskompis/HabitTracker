//
//  CreateAccountView.swift
//  HabitTracker
//
//  Created by Camilla Falk on 2025-04-29.
//

import SwiftUI

struct CreateAccountView: View {
    
    @State var name : String = ""
    @State var username : String = ""
    @State var password : String = ""
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
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
                    
                    Text("Create account")
                        .font(.title)
                        .fontDesign(.monospaced)
                    
                    VStack(alignment: .leading, spacing: 15){
                        
                        Text("Name")
                            .fontDesign(.monospaced)
                        
                        TextField("Name", text: $name)
                            .customStyleTextFields()
                        
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
                            Button("Create account") {
                                
                            }
                            .customStyleButton()
                            
                            Spacer()
                        }
                    }
                }.padding()
            }
        }
    }
}

#Preview {
    CreateAccountView()
}
