//
//  HomeScreen.swift
//  QuizUp
//
//  Created by dator on 2023-10-16.
//

import SwiftUI

struct HomeScreen: View {
    
    @ObservedObject var db: DatabaseConfig
    
    var body: some View {
            ZStack{
            LinearGradient(gradient: Gradient(colors: [Color.homeScreenGradientLight, Color.homeScreenGradientDark]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        .edgesIgnoringSafeArea(.all)
                HStack {
                    Button(action: {
                        
                    }) {
                        Image(systemName: "chart.bar.fill").font(.title2).foregroundColor(.white)
                    }.padding()
                    Spacer()
                    Image("Icon5").resizable().aspectRatio(contentMode: .fit).frame(width: 175, height: 175)
                    Spacer()
                    Button(action: {
                        
                    }) {
                        Image(systemName: "gearshape.fill").font(.title).foregroundColor(.white)
                    }.padding()
                }.offset(y: -340)
                VStack {
                    Text("Välkommen").font(.system(size: 30, design:
                            .rounded)).fontWeight(.heavy).foregroundColor(.white)
                }.offset(y: -230)
                VStack {
                    NavigationLink(destination: HomeScreen(db: DatabaseConfig()), isActive: $isNavigating) {
                            EmptyView()
                        }
    ) {
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 270, height: 56)
                                .background(Color("ButtonColor"))
                                .cornerRadius(20)
                                .shadow(radius: 4)
                                .overlay(
                                    Text("Skapa")
                                        .font(.system(size: 16, design: .rounded))
                                        .fontWeight(.bold)
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(.white)
                                )
                        }
        }
    }}

#Preview {
    HomeScreen(db: DatabaseConfig())
}
