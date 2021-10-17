//
//  ShoesMarketApp.swift
//  ShoesMarket
//
//  Created by Дарья Федяшова on 03.08.2021.
//

import SwiftUI
import Firebase

@main
struct ShoesMarketApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

// Инициализация БД FireBase
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        
        return true
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
    }
}
