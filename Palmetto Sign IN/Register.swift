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
                //.frame(width: 300, height: 800)  // CAM
                
            //VStack {
                
            Rectangle()
                .background(.white).opacity(0.1).cornerRadius(20)
                .frame(width: 800, height: 850)
                //-------------------------------------
                VStack(alignment: .leading) {
                    
                    
                    // EMAIL TEXT FIELD

                    TextField("Enter email address", text: $email)
                        .frame(maxWidth: .infinity, minHeight: 70)
                        .padding(.leading,75)
                        .focused($isFocused)
                        .keyboardType(.emailAddress)
                        .font(.system(size: 35.0))
                        .background(Color.gray.opacity(0.3).cornerRadius(10))
                        .padding(.bottom, 20)
                        .textCase(.lowercase)
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                        .background(
                    
                    ZStack(alignment: .leading) {
                        Image(systemName: "envelope")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 35)
                            .padding(.bottom)
                            .font(.system(size: 16,weight: .semibold))
                            .padding(.leading,-370)
                            .foregroundColor(Color.gray.opacity(0.5))
                        //


                    }
                    )//.textFieldStyle(RoundedBorderTextFieldStyle())
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                isFocused = true
                            }
                        }
 
                        
                    
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
                                        
                                        // CAM
                                        let newPerson = Person(firstName: "", lastName: "", email: email, username: "", role: "", reasonForVisit: "", date: Date())
                                        
                              
                                        
                                        dataService.currentPerson = newPerson
                                        showNewScreen = false
                                        showSignINView = true
                                    } else {
                                        print("User Found")
                                        //Person found so create a new person with the ReturnedPerson object
                                        
                                        // CAM
                                        
                                        let newPerson = Person(firstName: person?.firstName ?? "", lastName: person?.lastName ?? "", email: person?.email ?? "", username: person?.username ?? "", role: person?.role ?? "", reasonForVisit: person?.reasonForVisit ?? "", date: Date())
                                        //, active:person?.active ?? true)
                                        
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
                                //.font(.system(size: 40))
                                .shadow(radius: 10)
                    })
                    
                    }
                    //.padding(.vertical, 20)
                    //Spacer()
                 
                       
                    
                }

                .padding(30)
                //.padding(.bottom, 200)
                Text(campus)
                    .font(.system(size: 30.0))
                    .padding(.top,400)

                Text(Date.now.formatted(date:.long, time: .omitted))
                .font(.system(size: 20.0))
                    .foregroundColor(.gray)
                    .padding(.top,500)



                //Spacer()
            //}
           
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



