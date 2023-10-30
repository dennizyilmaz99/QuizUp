//
//  ContentView.swift
//  QuizUp
//
//  Created by dator on 2023-10-11.
//

import SwiftUI

struct CreateAccScreen: View {
    
    @ObservedObject var db: DatabaseConfig
    @State var isNavigating: Bool = false
    @State var name: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    private let shadowColor: Color = .init(red: 197/255, green: 197/255, blue: 197/255)
    private let baseColor: Color = .init(red: 232/255, green: 232/255, blue: 232/255)
  

    
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
                                        .padding(8)
                                        .background(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color("ButtonColor"), lineWidth: 2)
                                                .shadow(color: .black, radius: 20))
                            // Maybe att textFieldStyle to email
                          TextField("E-post", text: $email)
                                .padding(8)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color("ButtonColor"), lineWidth: 2)
                                )
                            // Maybe change to secureField instead for password
                          SecureField("Lösenord", text: $password)
                                .padding(8)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color("ButtonColor"), lineWidth: 2)
                                )
                            SecureField("Bekräfta lösenord", text: $confirmPassword)
                                  .padding(8)
                                  .background(
                                      RoundedRectangle(cornerRadius: 10)
                                          .stroke(Color("ButtonColor"), lineWidth: 2)
                                  )
                            NavigationLink(destination: HomeScreen(db: DatabaseConfig()    ), isActive: $isNavigating) {
                                    EmptyView()
                                }
                                Button(action: {
                                    if !email.isEmpty && !password.isEmpty && !name.isEmpty && confirmPassword == password {
                                        _ = db.registerUser(name: name, email: email, password: password)
                                        isNavigating = true // Enable the navigation
                                    } else {
                                        print("Error did not go")
                                        isNavigating = false
                                    }
                                }) {
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
                        }.padding(42)).shadow(radius: 20 )
                }.offset(y: -50)
            }
    }
}

#Preview {
    CreateAccScreen(db: DatabaseConfig())
}
