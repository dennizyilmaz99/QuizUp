//
//  LoginScreen.swift
//  QuizUp
//
//  Created by dator on 2023-10-16.
//

import SwiftUI

struct LoginScreen: View {
    
    @ObservedObject var db: DatabaseConfig
    @State var isNavigating: Bool = false
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
                  .background(Color("ButtonColor"))
                  .cornerRadius(20)
                  .overlay(
                    VStack (spacing: 25){
                        // Maybe att textFieldStyle to email
                        TextField("", text: $email, prompt: Text("E-post").foregroundColor(Color.color5).font(.system(size: 15)))
                            .padding(8)
                            .background(RoundedRectangle(cornerRadius: 10).stroke(.purple, lineWidth: 5))
                            .background(Color(.color4))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        // Maybe change to secureField instead for password
                        SecureField("", text: $password, prompt: Text("Lösenord").foregroundColor(Color.color5).font(.system(size: 15)))
                            .padding(8)
                            .background(RoundedRectangle(cornerRadius: 10).stroke(.purple, lineWidth: 5))
                            .background(Color(.color4))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        NavigationLink(destination: HomeScreen(), isActive: $isNavigating) {
                                EmptyView()
                            }
                            Button(action: {
                                if (!email.isEmpty && !password.isEmpty) {
                                    _ = db.logInUser(email: email, password: password)
                                    isNavigating = true // Enable the navigation
                                } else {
                                    print("Error")
                                    isNavigating = false
                                }
                            }) {
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: 270, height: 56)
                                    .background(Color("ButtonColor"))
                                    .cornerRadius(20)
                                    .shadow(color: Color.black.opacity(0.2), radius: 20)
                                    .overlay(
                                        Text("Logga in")
                                            .font(.system(size: 16, design: .rounded))
                                            .fontWeight(.bold)
                                            .multilineTextAlignment(.center)
                                            .foregroundColor(.white)
                                    )
                            }
                    }.padding(42))
            }
        }.navigationBarBackButtonHidden(true).navigationBarItems(leading: CustomBackBtn())
    }
    struct CustomBackBtn: View {
        
        @Environment(\.presentationMode) var presentationMode
        
        var body: some View {
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    Image(systemName: "arrow.left")
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    LoginScreen(db: DatabaseConfig())
}
