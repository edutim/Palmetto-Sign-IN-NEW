//
//  Register.swift
//  Palmetto Sign IN
//
//  Created by Chris Maggio on 2/25/23.
//

import SwiftUI

struct Register: View {
    @State private var email: String = ""
    
    //@Environment(\.presentationMode) var presentationMode
    @Binding var showNewScreen: Bool
    @Binding var showSignINView: Bool
    @FocusState private var isFocused: Bool
    
    @EnvironmentObject var dataService: DataService
    @AppStorage("campus") var campus: String = "Campus"


    var body: some View {
        
        ZStack {
            Color.lightGray.ignoresSafeArea()
            
            VStack {
                
                
                VStack(alignment: .leading) {
                    
                    // EMAIL TEXT FIELD
                    
                    TextField("Enter email address", text: $email)
                        .padding()
                        .focused($isFocused)
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
                            showNewScreen.toggle()
                            
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
                                        let newPerson = Person(firstName: "", lastName: "", email: email, username: "", role: "", reasonForVisit: "", date: Date())
                                        dataService.currentPerson = newPerson
                                        showNewScreen = false
                                        showSignINView = true
                                    } else {
                                        print("User Found")
                                        //Person found so create a new person with the ReturnedPerson object
                                        let newPerson = Person(firstName: person?.firstName ?? "", lastName: person?.lastName ?? "", email: person?.email ?? "", username: person?.username ?? "", role: person?.role ?? "", reasonForVisit: person?.reasonForVisit ?? "", date: Date())
                                        dataService.currentPerson = newPerson
                                        showNewScreen = false
                                        showSignINView = true
                                    }
                                }
                                
                            }
                            if emailIsAppropriate() {
                                //showNewScreen.toggle()
                                
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
                    .padding(.vertical, 20)
                    Spacer()
                 
                       
                    
                }
                .padding(30)
                .padding(.top, 200)
                Text(campus)
                    .font(.system(size: 40.0))

                Text(Date.now.formatted(date:.long, time: .omitted))
                    .font(.largeTitle)
                    .foregroundColor(.gray)



                Spacer()
            }
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

struct Register_Previews: PreviewProvider {
    static var previews: some View {
        Register(showNewScreen: .constant(true), showSignINView: .constant(false))
        
        
    }
}


