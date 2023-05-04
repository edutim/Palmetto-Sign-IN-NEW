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
    @FocusState private var isFocused: Bool
    @Environment(\.managedObjectContext) private var viewContext


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
                Text("Walterboro, East Campus")
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
        Register(showNewScreen: .constant(true))
        
        
    }
}


