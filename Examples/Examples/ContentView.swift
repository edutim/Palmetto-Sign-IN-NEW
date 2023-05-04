//
//  ContentView.swift
//  Examples
//
//  Created by Chris Maggio on 2/26/23.
//

import SwiftUI


struct ContentView: View {
    @FetchRequest(sortDescriptors: []) var students: FetchedResults<Student>
    var body: some View {
        Text("Hello World")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
