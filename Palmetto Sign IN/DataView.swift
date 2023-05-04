//
//  DataView.swift
//  Palmetto Sign IN
//
//  Created by Chris Maggio on 3/8/23.
//

import SwiftUI
import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "SignIN")
}

init() {
    container.loadPersistentStores { description, error in
        if let error = error {
            print("Core Data failed to load: \(error.localizedDescription)")
        }
    }
}

struct DataView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct DataView_Previews: PreviewProvider {
    static var previews: some View {
        DataView()
    }
}
