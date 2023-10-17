//
//  LoginScreen.swift
//  QuizUp
//
//  Created by dator on 2023-10-16.
//

import SwiftUI

struct LoginScreen: View {
    
    @State var email = ""
    @State var password = ""
    
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
                  .overlay(
                    VStack (spacing: 50){
                        // Maybe att textFieldStyle to email
                      TextField("E-post", text: $email)
                            .padding(10)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("ButtonColor"), lineWidth: 2)
                            )
                        // Maybe change to secureField instead for password
                      TextField("Lösenord", text: $password)
                            .padding(10)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("ButtonColor"), lineWidth: 2)
                            )
                            NavigationLink(destination: HomeScreen()) {
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: 270, height: 56)
                                    .background(Color("ButtonColor"))
                                    .cornerRadius(20)
                                    .overlay(
                                        // Maybe add another field to repeat the password and check if it's equal
                                    Text("Skapa konto")
                                        .font(.system(size: 16, design:
                                                .rounded)).fontWeight(.bold)
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(.white)
                                    )
                            }
                            .onTapGesture {
                                // Add terms here on navigationLink
                            }
                    }.padding())
            }
        }
    }
}

#Preview {
    LoginScreen()
}
