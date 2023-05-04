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
            Text("Hi")
            Text(formattedTime(time: dataService.elapsedTime))
            Button("OK") {
                dismiss()
                showSignOut = false
            }
        }
        
    }
    
    func formattedTime(time: String) -> String {
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
}
//
//struct SignedOutSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        SignedOutSheet()
//    }
//}
