//
//  SignedInSheet.swift
//  Palmetto Sign IN
//
//  Created by Timothy Hart on 5/4/23.
//

import SwiftUI

struct SignedInSheet: View {
    @Binding var showSignIn: Bool
    @Binding var showNewScreen: Bool
    @EnvironmentObject var dataService: DataService
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Image("signIn")
                .resizable()
                .scaledToFit()
                .frame(width: 200)
            Text("Welcome")
                .font(.largeTitle)
                .foregroundColor(Color(red: 10 / 255, green: 144 / 255, blue: 39 / 255))
            Text("\(dataService.currentPerson?.firstName ?? "Hi"), you are signed in to iCarolina lab at \(formattedTime(date: Date())).")
                .font(.title)
                //.font(.system(size: 60))
            Button("OK") {
                dismiss()
                showSignIn = false
            }
            .buttonStyle(BorderedProminentButtonStyle())
            .tint(.green)
            
        }
        .onAppear() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                dismiss()
                showNewScreen = false
            }
        }
    }
    
    func formattedTime(date: Date) -> String {
        
        
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        formatter.locale = Locale.current
        
        let formattedString = formatter.string(from: date)
        return formattedString
       
    }
}

//struct SignedInSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        SignedInSheet()
//    }
//}
