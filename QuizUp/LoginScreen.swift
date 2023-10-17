//
//  LoginScreen.swift
//  QuizUp
//
//  Created by dator on 2023-10-16.
//

import SwiftUI

struct LoginScreen: View {
    var body: some View {
        ZStack{
            Image("NewBgQuizUp")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            Text("Logga in")
                .font(.system(size: 36, design: .rounded)).fontWeight(.bold)
              .multilineTextAlignment(.center)
              .foregroundColor(.white).offset(y: -250)
            ZStack{
                Rectangle()
                  .foregroundColor(.clear)
                  .frame(width: 351, height: 329)
                  .background(.white)
                  .cornerRadius(20)
            }
        }
    }
}

#Preview {
    LoginScreen()
}
