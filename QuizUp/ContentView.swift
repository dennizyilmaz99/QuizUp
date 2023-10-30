//
//  ContentView.swift
//  QuizUp
//
//  Created by Aran Ali on 2023-10-30.
//

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
