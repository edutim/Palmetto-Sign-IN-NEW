//
//  CoreDataTestApp.swift
//  CoreDataTest
//
//  Created by Chris Maggio on 3/11/23.
//

import SwiftUI

@main
struct CoreDataTestApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
