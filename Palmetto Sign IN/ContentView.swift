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
    
    @State private var showRegisterView: Bool = false
    @State private var showSignINView = false
    @State private var showSignOutView = false
    @State private var opacity = 1.0
    
    @State var showSettings = false
    @State var settingsPassword = "1234" // This is is the password to get into the settings. Should be only numbers.
    @State var settingsPasswordText = ""
    @State var showSettingsAlert = false
    
    @AppStorage("campus") var campus: String = "Campus"
    
    var body: some View {
            
            
            ZStack {
                
                Color.lightGray.ignoresSafeArea()
                
                
                
                VStack(spacing: 0){
                    Text("iCarolina Lab")
                        .font(.system(size: 80.0, weight: .bold))
                        .padding(.bottom, 150)
                    Text("version 1.0")
                        .font(.caption)
                        .onTapGesture() {
                            showSettingsAlert = true
                        }
                        .alert("Settings Password", isPresented: $showSettingsAlert) {
                            TextField("Enter your name", text: $settingsPasswordText)
                                .keyboardType(.numberPad)
                            Button("OK") {
                                if settingsPassword == settingsPasswordText {
                                    showSettings = true
                                    settingsPasswordText = ""
                                } else {
                                    
                                }
                            }
                        }
                        .sheet(isPresented: $showSettings, content: {
                            SettingsView()
                        })
                    Button(action: {
                        showRegisterView.toggle()
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
                        showSignOutView = true
                        
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
                    Text(campus)
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
                    if showRegisterView {
                        Register(showNewScreen: $showRegisterView, showSignINView: $showSignINView)
                            .padding(.top, 200)
                            .transition(.move(edge: .bottom))
                            .animation(.spring())
                    }
                    if showSignINView {
                        SignIN(showNewScreen: $showSignINView)
                            .padding(.top, 200)
                            .transition(.move(edge: .bottom))
                            .animation(.spring())
                    }
                    if showSignOutView {
                        SignOUT(showSignOut: $showSignOutView)
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


