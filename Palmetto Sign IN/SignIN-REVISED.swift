//
//  SignIN.swift
//  Palmetto Sign IN
//
//  Created by Chris Maggio on 2/25/23.
//

import SwiftUI


struct SignIN: View {
    @Binding var showNewScreen: Bool
    let person: Person? = nil
    
    @State private var email: String = ""
    @State private var firstName: String = ""
    @State private var lastName:  String = ""
    @State private var reason:    String = ""
    @State private var isActive:  Bool = false      // added active CAM 5/5
    @FocusState private var isFocused: Bool         // CAM
    
    @State private var roleSelection = "Student"
    @State private var roleOptions = ["Student", "Faculty", "Staff", "Community"]
    
    @State var showAlert = false
    @State private var showSignInSheet = false
    
    @State private var showingAlert = false
    
    
    
    @EnvironmentObject var dataService: DataService
    @AppStorage("campus") var campus: String = "Campus"
    
    var body: some View {
        ZStack {
            Color.white //.ignoresSafeArea()
            //.frame(width: 300, height: 800)  // CAM
            
        //VStack {
            

        Rectangle()
            .background(.white).opacity(0.1).cornerRadius(20)
            .frame(width: 770, height: 1200)
           // -------------------------------------
            .overlay(
                Group {

                    Text("iCarolina Lab") // \n\n\n")
                        .padding(.top,100)
                        .foregroundColor(.black)
                        .font(.system(size: 75))
                        .fontWeight(.heavy)
                        //.padding(.bottom,40)
                    Text(campus)
                        .font(.system(size: 30.0))
                        .padding(.top,200)
                    Text(Date.now.formatted(date:.long, time: .omitted))
                        .font(.system(size: 25.0))
                        .foregroundColor(.gray)
                        .padding(.top,255)


                }

                
                
                , alignment: .top
                    
//                Text(campus)
//                    .font(.system(size: 30.0))
//
//                Text(Date.now.formatted(date:.long, time: .omitted))
//                    .font(.system(size: 25.0))
//                    .foregroundColor(.gray)
            )
            VStack {
                
                
                //Spacer()
                
                TextField("Email address", text: $email)
                    .padding()
                    .font(.system(size: 30.0))
                
                    .background(Color.blue.opacity(0.3).cornerRadius(10))
                    .padding(.bottom, 1)
                
                
                TextField("First name", text: $firstName)
                    .padding()
                    .font(.system(size: 30.0))
                    .background(Color.gray.opacity(0.3).cornerRadius(10))
                    .padding(.bottom, 1)
                
                
                TextField("Last name", text: $lastName)
                    .padding()
                    .font(.system(size: 30.0))
                    .background(Color.gray.opacity(0.3).cornerRadius(10))
                    .padding(.bottom, 1)
                
                TextField("Reason for your visit", text: $reason)
                    .padding()
                    .focused($isFocused)
                    .font(.system(size: 30.0))
                    .background(Color.gray.opacity(0.3).cornerRadius(10))
                    .padding(.bottom, 20)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            isFocused = true
                        }
                    }
                
                
                Picker("", selection: $roleSelection) {
                    ForEach(roleOptions, id: \.self) {
                        Text($0)
                        
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(height: 65)
                .background(.gray).cornerRadius(10)
                .font(.largeTitle)
                
                Text("Role selected: \(roleSelection)")
                    .font(.largeTitle)
                
                
                HStack {
                    
                    Button(action: {
                        //dismiss
                        withAnimation {
                            showNewScreen = false
                        }
                        
                    }, label: {
                        Text("Cancel")
                            .padding(40)
                        //.frame(maxWidth: .infinity)
                            .background(Color.darkRed.cornerRadius(10))
                            .foregroundColor(.white).fontWeight(.bold)
                            .font(.largeTitle)
                            
                            .shadow(radius: 10)
                    })
                    
                    
                    Button(action: {
                        // Check all fields for content
                        if email == "" || firstName == "" || lastName == "" || reason == "" {
                            showAlert = true
                            return
                        }
                        

                        
                        
                        // CAM - added active bool 5/5/23
                        
                        let newPerson = Person(firstName: firstName, lastName: lastName, email: email, username: "", role: roleSelection, reasonForVisit: reason, campus: campus, date: Date()) //active: isActive)
                        dataService.signIn(person: newPerson)
                        //dismiss
                        withAnimation {
                            showSignInSheet = true
                        }
                        
                        
                        
                        
                    }, label: {
                        Text("Sign In")
                        
                            .padding(40)
                            .frame(maxWidth: .infinity)
                            .background(Color.darkGreen.cornerRadius(10))
                            .foregroundColor(.white).fontWeight(.bold)
                            .font(.largeTitle)
                            .shadow(radius: 10)
                    })
                    
                    
                }
                //.padding(30)
                //Spacer()
//                Text(campus)
//                    .font(.system(size: 30.0))
//
//                Text(Date.now.formatted(date:.long, time: .omitted))
//                    .font(.system(size: 25.0))
//                    .foregroundColor(.gray)
                
                
                
            }
            
            .padding(20)
            
        }
        .onAppear() {
            if let currentPerson = dataService.currentPerson {
                email = currentPerson.email
                firstName = currentPerson.firstName
                lastName = currentPerson.lastName
                roleSelection = currentPerson.role

            }
            UISegmentedControl.appearance().setTitleTextAttributes([.font : UIFont.preferredFont(forTextStyle: .headline)], for: .highlighted)
            UISegmentedControl.appearance().setTitleTextAttributes([.font : UIFont.preferredFont(forTextStyle: .largeTitle)], for: .normal)
        }
        .alert("Please fill out each field.", isPresented: $showAlert) {
            Button("OK", role: .cancel) {}
        }
        .sheet(isPresented: $showSignInSheet) {
            SignedInSheet(showSignIn: $showSignInSheet, showNewScreen: $showNewScreen)
        }
    }
    
}

struct NewUser_Previews: PreviewProvider {
    static var previews: some View {
        SignIN(showNewScreen: .constant(true))
    }
}

