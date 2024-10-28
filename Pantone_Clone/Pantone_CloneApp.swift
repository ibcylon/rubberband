//
//  Pantone_CloneApp.swift
//  Pantone_Clone
//
//  Created by Kanghos on 10/22/24.
//

import SwiftUI
import SwiftData

@main
struct Pantone_CloneApp: App {
//    var sharedModelContainer: ModelContainer = {
//        let schema = Schema([
//            Item.self,
//        ])
//        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
//
//        do {
//            return try ModelContainer(for: schema, configurations: [modelConfiguration])
//        } catch {
//            fatalError("Could not create ModelContainer: \(error)")
//        }
//    }()

    var body: some Scene {
        WindowGroup {
          MainTab()
        }
//        .modelContainer(sharedModelContainer)
    }
}
