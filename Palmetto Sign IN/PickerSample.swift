//
//  PickerSample.swift
//  Palmetto Sign IN
//
//  Created by Chris Maggio on 2/25/23.
//



import SwiftUI

extension UISegmentedControl {
    override open func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.setContentHuggingPriority(.defaultLow, for: .vertical)  // << here !!
    }
}

struct PickerSample: View {

@State private var selection = 0
@State private var roleOptions = ["Student", "Faculty", "Staff", "Community"]
    
init() {
    //this changes the "thumb" that selects between items
    //UISegmentedControl.appearance().selectedSegmentTintColor = .blue
    //and this changes the color for the whole "bar" background
    //UISegmentedControl.appearance().backgroundColor = .purple

    //this will change the font size

    UISegmentedControl.appearance().setTitleTextAttributes([.font : UIFont.preferredFont(forTextStyle: .headline)], for: .highlighted)
    UISegmentedControl.appearance().setTitleTextAttributes([.font : UIFont.preferredFont(forTextStyle: .largeTitle)], for: .normal)

    //these lines change the text color for various states
    //UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor : UIColor.blue], for: .selected)
    //UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor : UIColor.blue], for: .normal)
}
    



    var body: some View {
        VStack {
            
            Text("START")
            
            Picker("",selection: $selection) {
                
                Text("Student").tag(0)
                Text("Faculty").tag(1)
                Text("Staff").tag(2)
                Text("Community").tag(3)
            }.pickerStyle(SegmentedPickerStyle())
                .frame(height: 65)

                .background(.gray).cornerRadius(10)
               
            Text("Role selected: \(selection)")

        }
        
    }
}


    
struct PickerSample_Previews: PreviewProvider {
    static var previews: some View {
        PickerSample()
        
    }
}
    





