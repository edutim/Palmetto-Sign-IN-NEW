//
//  ExamplesApp.swift
//  Examples
//
//  Created by Chris Maggio on 2/26/23.
//

import SwiftUI

@main
struct ExamplesApp: App {
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
