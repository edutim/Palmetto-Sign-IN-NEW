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
    
    @State private var roleSelection = "Student"
    @State private var roleOptions = ["Student", "Faculty", "Staff", "Community"]
    
    @State var showAlert = false
    @State private var showSignInSheet = false
    
    @EnvironmentObject var dataService: DataService
    @AppStorage("campus") var campus: String = "Campus"
    
    var body: some View {
        ZStack {
            Color.lightGray.ignoresSafeArea()
            VStack {
                
                
                //Spacer()
                
                TextField("Email address", text: $email)
                    .padding()
                    .font(.system(size: 40.0))
                
                    .background(Color.blue.opacity(0.3).cornerRadius(10))
                    .padding(.bottom, 30)
                
                
                TextField("First name", text: $firstName)
                    .padding()
                    .font(.system(size: 40.0))
                    .background(Color.gray.opacity(0.3).cornerRadius(10))
                    .padding(.bottom, 10)
                
                
                TextField("Last name", text: $lastName)
                    .padding()
                    .font(.system(size: 40.0))
                    .background(Color.gray.opacity(0.3).cornerRadius(10))
                    .padding(.bottom, 10)
                
                TextField("Reason for your visit", text: $reason)
                    .padding()
                    .font(.system(size: 40.0))
                    .background(Color.gray.opacity(0.3).cornerRadius(10))
                    .padding(.bottom, 20)
                
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
                            //.font(.largeTitle)
                            .font(.system(size: 40))
                            .shadow(radius: 10)
                    })
                    
                    
                    Button(action: {
                        // Check all fields for content
                        if email == "" || firstName == "" || lastName == "" || reason == "" {
                            showAlert = true
                            return
                        }
                        
                        
                        
                        let newPerson = Person(firstName: firstName, lastName: lastName, email: email, username: "", role: roleSelection, reasonForVisit: reason, date: Date())
                        
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
                Spacer()
                Text(campus)
                    .font(.system(size: 40.0))
                
                Text(Date.now.formatted(date:.long, time: .omitted))
                    .font(.largeTitle)
                    .foregroundColor(.gray)
                
                
                
            }
            
            .padding(30)
            
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

