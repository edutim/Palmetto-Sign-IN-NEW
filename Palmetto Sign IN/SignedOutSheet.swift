//
//  SignedOutSheet.swift
//  Palmetto Sign IN
//
//  Created by Timothy Hart on 5/4/23.
//

import SwiftUI
import AVKit        // CAM -- added 5/5/23

struct SignedOutSheet: View {
    
    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    @State var count: Int = 8
    
    @State private var audioPlayer: AVAudioPlayer!  // CAM -- added 5/6/23
    
    @Binding var showSignOut: Bool
    @EnvironmentObject var dataService: DataService
    @Environment(\.dismiss) var dismiss
    @State var counter = 5
    
    var body: some View {(
        ZStack {
            // CAM - added rectangle 5/7/23
            Rectangle()
                .background(.white).opacity(0.1).cornerRadius(20)
                .frame(width: 680, height: 970)
                //-------------------------------------
            
            VStack {
                
                // CAM - added timer and message 5/7/23
                Text("Auto close in ..... \(count)")
                    .font(.system(size: 40))
                    .foregroundColor(.darkRed)
                    .padding(.vertical,20)
                
                Text( "\(dataService.currentPerson?.firstName ?? "No Name") ")  // CAM - added "No Name"
                    .font(.system(size: 60))
                    .bold()
                
                //Image("signOut")
                Image(systemName: "figure.walk.motion")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                Text("Thank you for visiting iCarolina lab \n")
                    .font(.system(size: 40))
                //.foregroundColor(Color(red: 143 / 255, green: 17 / 255, blue: 25 / 255))
                
                //Text("Signed Out \(dataService.currentPerson?.firstName ?? "")at \(formattedTime(date: Date())).")
                Text("Signed Out at \(formattedTime(date: Date())).")
                    .font(.system(size: 40))
                    .foregroundColor(Color(red: 143 / 255, green: 17 / 255, blue: 25 / 255))
                    .bold()
                //Text("\(dataService.currentPerson?.firstName ?? "Hi"), you signed out at \(formattedTime(date: Date())).")
                //Text("Signed out at ")
                //    .font(.title)
                // Text(" \(formattedTime(date: Date()))")
                //    .font(.largeTitle)
                //    .bold()
                Text("\(formattedElapsedTime(time: dataService.elapsedTime)) in lab")
                    .font(.system(size: 40))
                
                Button(action: {
                    self.timer.upstream.connect().cancel()   // CAM
                    dismiss()
                    showSignOut = false
                   
                }, label: {
                    Text("OK")
                        .font(.system(size: 40))
                        .bold()
                        .foregroundColor(.white)
                        .frame(height: 125)
                        .frame(maxWidth:.infinity)
                        .background(Color.darkGreen)
                        .shadow(color: Color.blue.opacity(0.3),
                                radius: 10, x: 0.0, y:10)
                    
                })
                //            Button("OK") {
                //                dismiss()
                //                showSignOut = false
                //            }
                //            .controlSize(.large)
                ////            .buttonStyle(BorderedProminentButtonStyle())
                ////            .tint(.green)
                //            //.padding(.horizontal, 100)
                //            //.frame(maxWidth: .infinity)
                //            .background(Color.darkGreen) //.cornerRadius(10))
                //            .foregroundColor(.white).fontWeight(.bold)
                //            //.font(.largeTitle)
                //            .font(.system(size: 40))
                //            .shadow(radius: 10)
            }
      

            
            .onReceive(timer, perform: { _ in
                if count > 0 {
                    count -= 1
                    
                } else if count <= 0 {
                    self.timer.upstream.connect().cancel()   // CAM
                }
                    
            })
            
            .onAppear() {
                
                let sound = Bundle.main.path(forResource: "ThankYou", ofType: "mp3")
                self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
                self.audioPlayer.play()
                DispatchQueue.main.asyncAfter(deadline: .now() + 8.0) {
                    dismiss()
                    showSignOut = false
                }
            }
 
        }
        
        )}
    
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
