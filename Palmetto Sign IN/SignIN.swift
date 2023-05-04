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
    
    @State private var selection = 0
    @State private var roleOptions = ["Student", "Faculty", "Staff", "Community"]
    
    @State var showAlert = false
    
    @EnvironmentObject var dataService: DataService
    
//    init() {
        //this changes the "thumb" that selects between items
        //UISegmentedControl.appearance().selectedSegmentTintColor = .blue
        //and this changes the color for the whole "bar" background
        //UISegmentedControl.appearance().backgroundColor = .purple

        //this will change the font size

//        UISegmentedControl.appearance().setTitleTextAttributes([.font : UIFont.preferredFont(forTextStyle: .headline)], for: .highlighted)
//        UISegmentedControl.appearance().setTitleTextAttributes([.font : UIFont.preferredFont(forTextStyle: .largeTitle)], for: .normal)

        //these lines change the text color for various states
        //UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor : UIColor.blue], for: .selected)
        //UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor : UIColor.blue], for: .normal)
  //  }
    
    var body: some View {
        ZStack {
            Color.lightGray.ignoresSafeArea()
            VStack {
                
                Text("iCarolina Lab")
                    .font(.system(size: 80.0, weight: .bold))
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
                
                    Picker("",selection: $selection) {
                        Text("Student").tag(0)
                       Text("Faculty").tag(1)
                       Text("Staff").tag(2)
                       Text("Community").tag(3)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(height: 65)
                    .background(.gray).cornerRadius(10)
               
                Text("Role selected: \(roleOptions[selection])")
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
                        
                        var localRole = ""
                        switch selection {
                        case 0:
                            localRole = "Student"
                        case 1:
                            localRole = "Faculty"
                        case 2:
                            localRole = "Staff"
                        case 3:
                            localRole = "Community"
                        default:
                            print("This should never happen.")
                        }
                        
                        let newPerson = Person(firstName: firstName, lastName: lastName, email: email, role: localRole, reasonForVisit: reason, date: Date())
                       
                        dataService.signIn(person: newPerson)
                        //dismiss
                        withAnimation {
                            showNewScreen = false
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
                    .padding(.bottom, 200)
                    Text("Walterboro, East Campus")
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
                reason = currentPerson.reasonForVisit
                let role = person?.role ?? ""
                print(role)
                switch role {
                case "Student":
                    selection = 0
                case "Faculty":
                    selection = 1
                case "Staff":
                    selection = 2
                case "Community":
                    selection = 3
                default:
                    print("This should never happen.")
                }
            }
        }
        .alert("Please fill out each field.", isPresented: $showAlert) {
            Button("OK", role: .cancel) {}
        }
    }
}

struct NewUser_Previews: PreviewProvider {
    static var previews: some View {
        SignIN(showNewScreen: .constant(true))
    }
}

