import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct QuizUpApp: App {
    init() {
       
    }
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var users = DatabaseConfig()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(users)
        }
    }
}
