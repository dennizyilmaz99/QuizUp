//
//  ContentView.swift
//  QuizUp
//
//  Created by dator on 2023-10-11.
//

import SwiftUI

struct CreateAccScreen: View {
    
    @ObservedObject var db: DatabaseConfig
    @State var name: String = ""
    @State var email: String = ""
    @State var password: String = ""
    
    var body: some View {
            ZStack{
                Image("NewBgQuizUp")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                Text("Skapa konto")
                    .font(.system(size: 36, design: .rounded)).fontWeight(.bold)
                  .multilineTextAlignment(.center)
                  .foregroundColor(.white).offset(y: -325)
                ZStack{
                    Rectangle()
                      .foregroundColor(.clear)
                      .frame(width: 351, height: 400)
                      .background(.white)
                      .cornerRadius(20)
                      .overlay(
                        VStack (spacing: 30){
                          TextField("Namn", text: $name)
                                        .padding(10)
                                        .background(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color("ButtonColor"), lineWidth: 2)
                                        )
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
                }.offset(y: -50)
            }
    }
}

#Preview {
    CreateAccScreen(db: DatabaseConfig())
}
