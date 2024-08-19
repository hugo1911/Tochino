import SwiftUI
import Firebase
import FirebaseCore
//para que jale lo de mostrar en firebase tienes que irte a other linker flags y en debug y el otro tmb le pones -ObjC

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct Tochino: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var authenticationViewModel = AuthenticationViewModel()
    
    var body: some Scene {
        WindowGroup {
            if let _ = authenticationViewModel.user {
                HomeView(authenticationViewModel: authenticationViewModel)
            }else{
                AuthenticationView(authenticationViewModel: authenticationViewModel)
                //Slot()
            }
        }
    }
}
