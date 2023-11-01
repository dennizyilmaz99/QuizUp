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
                .foregroundColor(.white).offset(y: -300)
            ZStack{
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 351, height: 450)
                    .background(Color("ButtonColor"))
                    .cornerRadius(20)
                    .overlay(
                        VStack (spacing: 30){
                            TextField("", text: $name, prompt: Text("Namn").foregroundColor(Color.color5).font(.system(size: 15)))
                                .padding(8)
                                .background(RoundedRectangle(cornerRadius: 10).stroke(.purple, lineWidth: 5))
                                .background(Color(.color4))
                                .foregroundColor(.white)
                                .cornerRadius(10)
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
                            SecureField("", text: $confirmPassword, prompt: Text("Bekräfta lösenord").foregroundColor(Color.color5).font(.system(size: 15)))
                                .padding(8)
                                .background(RoundedRectangle(cornerRadius: 10).stroke(.purple, lineWidth: 5))
                                .background(Color(.color4))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                            NavigationLink(destination: HomeScreen(), isActive: $isNavigating) {
                                EmptyView()
                            }
                            Button(action: {
                                if !email.isEmpty && !password.isEmpty && !name.isEmpty && confirmPassword == password {
                                    _ = db.registerUser(name: name, email: email, password: password)
                                    isNavigating = true // Enable the navigation
                                } else {
                                    print("Error did not go")
                                    isNavigating = false
                            NavigationLink(destination: HomeScreen(), isActive: $isNavigating) {
                                EmptyView()
                            }
                            Button(action: {
                                if !email.isEmpty && !password.isEmpty && !name.isEmpty && confirmPassword == password {
                                    _ = db.registerUser(name: name, email: email, password: password)
                                    isNavigating = true // Enable the navigation
                                } else {
                                    print("Error did not go")
                                    isNavigating = false
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
                            NavigationLink(destination: HomeScreen(), isActive: $isNavigating) {
                                    EmptyView()
                                }
                            }) {
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: 270, height: 56)
                                    .background(Color("ButtonColor"))
                                    .cornerRadius(20)
                                    .shadow(color: Color.black.opacity(0.2), radius: 20)
                                    .overlay(
                                        Text("Skapa")
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
    CreateAccScreen(db: DatabaseConfig())
}
