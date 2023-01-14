//
//  SimplifyApp.swift
//  Simplify
//
//  Created by Fatma Gazwani on 21/06/1444 AH.
//

import SwiftUI

@main
struct SimplifyApp: App {
    let persistentContainer = CoreDataManager.shared.persistentContainer

    var body: some Scene {
        WindowGroup {
//            LoadingView().environment(\.managedObjectContext, persistentContainer.viewContext)

            ContentView()
                .environment(\.managedObjectContext, persistentContainer.viewContext)

        }
    }
}
