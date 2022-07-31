//
//  NOBEMedDeviceAKApp.swift
//  NOBEMedDeviceAK
//
//  Created by Anshul Kaushik on 7/29/22.
//

import SwiftUI

@main
struct NOBEMedDeviceAKApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
        let _ = Backend.initialize()
        
        return true
    }
}
