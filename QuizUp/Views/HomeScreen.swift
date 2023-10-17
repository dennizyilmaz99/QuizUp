//
//  HomeScreen.swift
//  QuizUp
//
//  Created by dator on 2023-10-16.
//

import SwiftUI

struct HomeScreen: View {
    var body: some View {
            ZStack{
            LinearGradient(gradient: Gradient(colors: [Color.homeScreenGradientLight, Color.homeScreenGradientDark]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        .edgesIgnoringSafeArea(.all)
                HStack{
                    Button(action: {
                        
                    }) {
                        Image(systemName: "chart.bar.fill").font(.title2).foregroundColor(.white)
                    }.padding()
                    Spacer()
                    Image("Icon2").resizable().aspectRatio(contentMode: .fit).frame(width: 175, height: 175)
                    Spacer()
                    Button(action: {
                        
                    }) {
                        Image(systemName: "gearshape.fill").font(.title).foregroundColor(.white)
                    }.padding()
            }.offset(y: -340)
        }.navigationBarBackButtonHidden(true)
    }
}

#Preview {
    HomeScreen()
}
