//
//  SignedInSheet.swift
//  Palmetto Sign IN
//
//  Created by Timothy Hart on 5/4/23.
//

import SwiftUI
import AVKit

struct SignedInSheet: View {
    
    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    @State var count: Int = 8
    
    @State private var audioPlayer: AVAudioPlayer!
    
    @Binding var showSignIn: Bool
    @Binding var showNewScreen: Bool
    @EnvironmentObject var dataService: DataService
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        ZStack {
            // CAM - added 5/7/23
            Rectangle()
                .background(.white).opacity(0.1).cornerRadius(20)
                .frame(width: 680, height: 970)
            
            VStack {
                
                Text("Auto close in ..... \(count)")
                    .font(.system(size: 40))
                    .foregroundColor(.darkRed)
                    .padding(.vertical,20)
                
                
                //Image("signIn")
                Image(systemName: "figure.walk.arrival")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                Text("Welcome \(dataService.currentPerson?.firstName ?? "Hi")")
                //.font(.largeTitle)
                    .font(.system(size: 60))
                    .bold()
                    .foregroundColor(Color(red: 10 / 255, green: 144 / 255, blue: 39 / 255))
                //Text("\(dataService.currentPerson?.firstName ?? "Hi"), you are signed in to iCarolina lab at \(formattedTime(date: Date())).")
                //    .font(.title)
                //.font(.system(size: 60))
                Text("Signed in at \(formattedTime(date: Date())).")
                    .font(.largeTitle)
                
                Button(action: {
                    self.timer.upstream.connect().cancel()
                    dismiss()
                    showSignIn = false
                    showNewScreen = false
                }, label: {
                    Text("OK")
                        .font(.largeTitle)
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
                //                showSignIn = false
                //                showNewScreen = false
                //            }
                //            //.background(.white)
                //            .padding(40)
                //            .frame(maxWidth: .infinity)
                //            .background(Color.darkGreen) //.cornerRadius(10))
                //            .foregroundColor(.white).fontWeight(.bold)
                //            //.font(.largeTitle)
                //            .font(.system(size: 40))
                //            .shadow(radius: 10)
                ////            .buttonStyle(BorderedProminentButtonStyle())
                ////            .tint(.green)
                
            }
            .onReceive(timer, perform: { _ in
                if count > 0 {
                    count -= 1
                    
                } else if count <= 0 {
                    self.timer.upstream.connect().cancel()   // CAM
                }
                
            })
            .onAppear() {
                let sound = Bundle.main.path(forResource: "Welcome", ofType: "mp3")
                self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
                self.audioPlayer.play()
                DispatchQueue.main.asyncAfter(deadline: .now() + 8.0) {
                    dismiss()
                    showNewScreen = false
                }
            }
        }
    }
//    func playSound(){
//
//            //getting the resource path
//            let resourcePath = Bundle.main.url(forResource: "Welcome", withExtension: "m4a")
//
//            do{
//                //initializing audio player with the resource path
//                audioPlayer = try AVAudioPlayer(contentsOf: resourcePath!)
//
//                //play the audio
//                audioPlayer?.play()
//
//                //stop the audio
//                // audioPlayer?.stop()
//
//            }
//            catch{
//              //error handling
//                print(error.localizedDescription)
//            }
//        }
//

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
