//
//  PraveenKumar_MVVMApp.swift
//  PraveenKumar_MVVM
//
//  Created by 1976969 on 23/07/25.
//

import SwiftUI
import SwiftData

@main
struct PraveenKumar_MVVMApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
//            CustomerDataModel.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
