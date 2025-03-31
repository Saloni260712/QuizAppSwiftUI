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
            HomeView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
