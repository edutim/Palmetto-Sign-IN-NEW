//
//  ContentView.swift
//  Palmetto Sign IN
//
//  Created by Chris Maggio on 2/24/23.
//

import SwiftUI

extension Color {
    static let lightGray = Color(red: 221/255, green: 222/255, blue: 224/255)
    static let darkRed = Color(red: 123/255, green: 16/255, blue:8/255)
    static let darkGreen = Color(red: 21/255, green: 155/255, blue:26/255)
}

struct ContentView: View {
    
    @State private var showNewScreen: Bool = false
    @State private var opacity = 1.0
    
    var body: some View {
            
            
            ZStack {
                
                Color.lightGray.ignoresSafeArea()
                
                
                
                VStack(spacing: 0){
                    Text("iCarolina Lab")
                        .font(.system(size: 80.0, weight: .bold))
                        .padding(.bottom, 150)
                    
                    Button(action: {
                        showNewScreen.toggle()
//                        withAnimation {
//                            opacity -= 0.2
//                        }
                        
                    }, label: {
                        Text("IN")
                            .frame(width:250, height: 250)
                            .foregroundColor(.white).shadow(radius:5)
                            .font(.system(size: 86.0, weight: .bold))
                            .background(
                                Color.darkGreen
                                    .cornerRadius(10)
                                    .shadow(radius:10)
                                
                            )
                            .padding(.bottom, 50)
                        
                    })

                    
                    
                    Button(action: {
                        
                        
                    }, label: {
                        Text("OUT")
                            .frame(width:250, height: 250)
                            .foregroundColor(.white).shadow(radius:5)
                            .font(.system(size: 86.0, weight: .bold))
                            .background(
                                Color.darkRed
                                    .cornerRadius(10)
                                    .shadow(radius:10)
                            )
                            .padding()
                        
                    })
                    .padding(.bottom, 200)
                    Text("Walterboro, East Campus")
                        .font(.system(size: 40.0))
                    
                    Text(Date.now.formatted(date:.long, time: .omitted))
                        .font(.largeTitle)
                        .foregroundColor(.gray)
                    
                    //Spacer()
                    
                    
                }
//                .sheet(isPresented: $showNewScreen, content: {
//                    Register()
//                })
                ZStack {
                    if showNewScreen {
                        Register(showNewScreen: $showNewScreen)
                            .padding(.top, 200)
                            .transition(.move(edge: .bottom))
                            .animation(.spring())
                    }
                }
                .zIndex(2.0)

            }
        
        }


    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


