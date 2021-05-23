//
//  MemoryApp.swift
//  Memory WatchKit Extension
//
//  Created by Guillermo Frias on 15/01/2021.
//

import SwiftUI

@main
struct MemoryApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView().environmentObject(State())
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
