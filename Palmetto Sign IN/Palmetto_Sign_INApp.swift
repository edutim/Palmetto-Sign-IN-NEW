//
//  Palmetto_Sign_INApp.swift
//  Palmetto Sign IN
//
//  Created by Chris Maggio on 2/24/23.
//

import SwiftUI

@main
struct Palmetto_Sign_INApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(DataService.shared)
        }
    }
}
