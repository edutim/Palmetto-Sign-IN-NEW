//
//  Sheets.swift
//  Examples
//
//  Created by Chris Maggio on 2/26/23.
//

import SwiftUI

struct Sheets: View {
    @State var showNewScreen: Bool = false
    var body: some View {
        ZStack {
            Color.orange
                .edgesIgnoringSafeArea(.all)
            VStack {
                Button("BUTTON") {
                    showNewScreen.toggle()
                }
                .font(.largeTitle)
                Spacer()
            }
            //            .sheet(isPresented: $showNewScreen, content: {
            //                NewScreen()
            //            })
            if showNewScreen {
                NewScreen(showNewScreen: $showNewScreen)
                    .padding(.top, 100)
                    .transition(.move(edge: .bottom))
                    .animation(.spring())
            }
        }
        }

    
}

struct NewScreen: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var showNewScreen: Bool
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.purple
                .edgesIgnoringSafeArea(.all)
            
            Button(action: {
                //presentationMode.wrappedValue.dismiss()
                showNewScreen.toggle()
            }, label: {
                Image(systemName: "xmark")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding(20)
            })
        }
    }
}

struct Sheets_Previews: PreviewProvider {
    static var previews: some View {
        Sheets()
    }
}
