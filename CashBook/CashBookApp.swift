//
//  CashBookApp.swift
//  CashBook
//
//  Created by MD Aminuzzaman on 1/22/24.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import GoogleSignIn


class AppDelegate: NSObject, UIApplicationDelegate
{
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions
                   launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool
  {
  

    return true
  }
    
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
      return GIDSignIn.sharedInstance.handle(url)
    }
}

@main
struct CashBookApp: App {
  // register app delegate for Firebase setup
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    @State var databaseViewModel: DatabaseViewModel
    @State var authViewModel: AuthViewModel
    
    init() {
        FirebaseApp.configure()
   
        self.databaseViewModel = DatabaseViewModel()
        self.authViewModel = AuthViewModel()
      
    }
    
  var body: some Scene {
    WindowGroup {
      NavigationView {
          SignUpView()
              .environment(authViewModel)
              .environment(databaseViewModel)
      }
    }
  }
}
