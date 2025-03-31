//
//  QuizAppSwiftUIApp.swift
//  QuizAppSwiftUI
//
//  Created by Meet Patel on 30/03/25.
//

import SwiftUI

@main
struct QuizAppSwiftUIApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
