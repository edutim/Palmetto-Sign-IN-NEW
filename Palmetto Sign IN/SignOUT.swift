//
//  SignOUT.swift
//  Palmetto Sign IN
//
//  Created by Timothy Hart on 5/4/23.
//

import SwiftUI

struct SignOUT: View {
    @Binding var showSignOut: Bool
    @State private var email: String = ""
    @EnvironmentObject var dataService: DataService
    
    @State private var showSignOutSheet = false
    
    @AppStorage("campus") var campus: String = "Campus"
    
    var body: some View {
        
        ZStack {
            Color.lightGray.ignoresSafeArea()
            
            VStack {
                Spacer()
                
                VStack(alignment: .leading) {
                    
                    // EMAIL TEXT FIELD
                    
                    TextField("Enter email address", text: $email)
                        .padding()
                        .keyboardType(.emailAddress)
                        .font(.system(size: 40.0))
                        .background(Color.gray.opacity(0.3).cornerRadius(10))
                        .padding(.bottom, 20)
                        .textCase(.lowercase)
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                    
                    
                    HStack {
                        
                        Button(action: {
                            //presentationMode.wrappedValue.dismiss()
                            showSignOut = false
                            
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
                            
                            Task {
                                let person = try await dataService.findPersonWith(email: email)
                                if let foundPerson = person {
                                    if foundPerson.email == "" {
                                        print("No user found")
                                        //No person was found so create a new Person with only an email address
                                        
                                    } else {
                                        print("User Found")
                                        //Person found so create a new person with the ReturnedPerson object
                                        let newPerson = Person(firstName: foundPerson.firstName, lastName: foundPerson.lastName, email: foundPerson.email, username: foundPerson.username, role: foundPerson.role, reasonForVisit: foundPerson.reasonForVisit, date: Date())
                                        
                                        await dataService.signOut(person: newPerson)
                                        showSignOutSheet = true
                                    }
                                }
                                
                            }
                            
                            
                        }, label: {
                            Text("Sign Out")
                            
                                .padding(40)
                                .frame(maxWidth: .infinity)
                                .background(Color.darkGreen.cornerRadius(10))
                                .foregroundColor(.white).fontWeight(.bold)
                                .font(.largeTitle)
                                .shadow(radius: 10)
                        })
                        
                    }
                    .padding(.vertical, 20)
                    
                   
                    
                    
                }
                .padding(30)
                
                Spacer()
                Text(campus)
                    .font(.system(size: 40.0))
                
                Text(Date.now.formatted(date:.long, time: .omitted))
                    .font(.largeTitle)
                    .foregroundColor(.gray)
                
                
                
            }
        }
        .sheet(isPresented: $showSignOutSheet) {
            SignedOutSheet(showSignOut: $showSignOut)
        }
        
    }
    func emailIsAppropriate() -> Bool {
        // validate email
        if email.count >= 6 {
            return true
        }
        return false
    }
}

struct SignOUT_Previews: PreviewProvider {
    static var previews: some View {
        SignOUT(showSignOut: .constant(false))
    }
}
