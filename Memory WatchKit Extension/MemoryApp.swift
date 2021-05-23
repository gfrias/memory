//
//  MemoryApp.swift
//  Memory WatchKit Extension
//
//  Created by Guillermo Frias on 23/05/2021.
//

import SwiftUI

@main
struct MemoryApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
