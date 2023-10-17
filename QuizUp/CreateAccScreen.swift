//
//  ContentView.swift
//  QuizUp
//
//  Created by dator on 2023-10-11.
//

import SwiftUI

struct CreateAccScreen: View {
    
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
                        VStack (spacing: 50){
                          TextField("Namn", text: $name)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                          TextField("E-post", text: $email)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .border(Color.black)
                          TextField("Lösenord", text: $password)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                NavigationLink(destination: HomeScreen()) {
                                    Rectangle()
                                        .foregroundColor(.clear)
                                        .frame(width: 270, height: 56)
                                        .background(Color("ButtonColor"))
                                        .cornerRadius(20)
                                        .overlay(
                                        Text("Skapa konto")
                                            .font(.system(size: 16, design:
                                                    .rounded)).fontWeight(.bold)
                                            .multilineTextAlignment(.center)
                                            .foregroundColor(.white)
                                        )
                                }
                        }.padding())
                }.offset(y: -50)
            }
    }
}

#Preview {
    CreateAccScreen()
}
