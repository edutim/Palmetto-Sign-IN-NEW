//
//  SignedOutSheet.swift
//  Palmetto Sign IN
//
//  Created by Timothy Hart on 5/4/23.
//

import SwiftUI

struct SignedOutSheet: View {
    @Binding var showSignOut: Bool
    @EnvironmentObject var dataService: DataService
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Image("signOut")
                .resizable()
                .scaledToFit()
                .frame(width: 200)
            Text("Signed Out")
                .font(.largeTitle)
                .foregroundColor(Color(red: 143 / 255, green: 17 / 255, blue: 25 / 255))
            Text("\(dataService.currentPerson?.firstName ?? "Hi"), you signed out at \(formattedTime(date: Date())).")
                .font(.title)
            Text("The total time this session is:")
                .font(.title)
            Text("\(formattedElapsedTime(time: dataService.elapsedTime))")
                .font(.system(size: 60))
            Button("OK") {
                dismiss()
                showSignOut = false
            }
            .buttonStyle(BorderedProminentButtonStyle())
            .tint(.green)
        }
        .onAppear() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                dismiss()
                showSignOut = false
            }
        }
        
        
    }
    
    func formattedElapsedTime(time: String) -> String {
        guard let time = Double(time) else { return "error "}
        let timeInterval: TimeInterval = abs(time)
        
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.hour, .minute]
        
        if let formattedString = formatter.string(from: timeInterval) {
            return formattedString
        } else {
            return "error"
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
//
//struct SignedOutSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        SignedOutSheet()
//    }
//}
