import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var users: DatabaseConfig
    
    var body: some View {
        VStack{
            if users.currentUser != nil {
                NavigationStack{
                    HomeScreen()
                }
                
            } else {
                NavigationStack{
                    LandingScreen()
                }
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
