//
//  SimplifyApp.swift
//  Simplify
//
//  Created by Fatma Gazwani on 21/06/1444 AH.
//

import SwiftUI

@main

    struct SimplifyApp: App {
        
        var body: some Scene {
            WindowGroup {
                let persistentContainer = CoreDataManager.shared.persistentContainer
            LoadingView().environment(\.managedObjectContext, persistentContainer.viewContext)
//                ContentView().environment(\.managedObjectContext, persistentContainer.viewContext)
//              EventsView().environment(\.managedObjectContext, persistentContainer.viewContext)
                
            }
        }
    }

