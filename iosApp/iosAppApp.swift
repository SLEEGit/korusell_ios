//
//  iosAppApp.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/11/28.
//

import SwiftUI
import Firebase
import FBSDKCoreKit

@main
struct iosAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL { url in
                  print("Received URL: \(url)")
                  Auth.auth().canHandle(url) // <- just for information purposes
                }
        }
    }
}




class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
      ApplicationDelegate.shared.application(
                  application,
                  didFinishLaunchingWithOptions: launchOptions
              )
    print("SwiftUI_2_Lifecycle_PhoneNumber_AuthApp application is starting up. ApplicationDelegate didFinishLaunchingWithOptions.")
    return true
  }

  func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    print("\(#function)")
    Auth.auth().setAPNSToken(deviceToken, type: .sandbox)
  }
  
  func application(_ application: UIApplication, didReceiveRemoteNotification notification: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
    print("\(#function)")
    if Auth.auth().canHandleNotification(notification) {
      completionHandler(.noData)
      return
    }
  }
  
  func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
    print("\(#function)")
      ApplicationDelegate.shared.application(
                  application,
                  open: url,
                  sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                  annotation: options[UIApplication.OpenURLOptionsKey.annotation]
              )
    if Auth.auth().canHandle(url) {
      return true
    }
    return false
  }
    
}
