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
    @State var showAlert = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                Image("NewBgQuizUp")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                ZStack{
                    Text("Skapa konto")
                        .font(.system(size: 36, design: .rounded)).fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white).offset(y: -300)
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 351, height: 485)
                        .background(Color("ButtonColor"))
                        .cornerRadius(20)
                        .overlay(
                            VStack (spacing: 20){
                                TextField("", text: $db.name, prompt: Text("Namn").foregroundColor(Color.color5).font(.system(size: 15)))
                                    .padding(8)
                                    .background(RoundedRectangle(cornerRadius: 10).stroke(.purple, lineWidth: 5))
                                    .background(Color(.color4))
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                
                                // Maybe att textFieldStyle to email
                                TextField("", text: $db.email, prompt: Text("E-post").foregroundColor(Color.color5).font(.system(size: 15)))
                                    .padding(8)
                                    .background(RoundedRectangle(cornerRadius: 10).stroke(.purple, lineWidth: 5))
                                    .background(Color(.color4))
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    .keyboardType(.emailAddress)
                                
                                SecureField("", text: $db.password, prompt: Text("Lösenord").foregroundColor(Color.color5).font(.system(size: 15)))
                                    .padding(8)
                                    .background(RoundedRectangle(cornerRadius: 10).stroke(.purple, lineWidth: 5))
                                    .background(Color(.color4))
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                
                                SecureField("", text: $db.confirmPassword, prompt: Text("Bekräfta lösenord").foregroundColor(Color.color5).font(.system(size: 15)))
                                    .padding(8)
                                    .background(RoundedRectangle(cornerRadius: 10).stroke(.purple, lineWidth: 5))
                                    .background(Color(.color4))
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                VStack {
                                    Text("Välj din ikon").font(.system(size: 14, design: .rounded)).foregroundStyle(.white).frame(maxWidth: .infinity, alignment: .leading).fontWeight(.bold)
                                    HStack(spacing: 15) {
                                        ForEach(["🦊", "🐻", "🐵", "🦁", "🐸"], id: \.self) { icon in
                                            Button(action: {
                                                // Sätt den valda ikonen när knappen trycks
                                                db.selectedIcon = icon
                                            }) {
                                                Text(icon)
                                                    .font(.title2)
                                                    .padding(10)
                                                    .background(db.selectedIcon == icon ? Color.white : Color.clear)
                                                    .clipShape(Circle())
                                            }
                                        }
                                    }
                                }
                                
                                NavigationLink(destination: HomeScreen(), isActive: $isNavigating) {
                                    EmptyView()
                                }
                                Button(action: {
                                    if db.validateCreateScreenFields() {
                                        db.registerUser(name: db.name, email: db.email, password: db.password, selectedIcon: db.selectedIcon) { success, message in
                                            DispatchQueue.main.async {
                                                if success {
                                                    isNavigating = true
                                                } else {
                                                    isNavigating = false
                                                    print("Error did not go")
                                                    db.alertMessage = message
                                                    showAlert = true
                                                }
                                            }
                                        }
                                    } else {
                                        // Hantera felen som 'validateFields' påträffade
                                        // Visa ett felmeddelande om något fält inte validerades korrekt
                                        showAlert = true
                                    }
                                }) {
                                    Rectangle()
                                        .foregroundColor(.clear)
                                        .frame(width: 260, height: 56)
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
                                }.alert(isPresented: $showAlert) {
                                    Alert(title: Text("Fel"), message: Text(db.alertMessage), dismissButton: .default(Text("OK")))
                                }
                            }.padding(42))
                }
            }.navigationBarBackButtonHidden(true).navigationBarItems(leading: CustomBackBtn())
        }
    }
    struct CustomBackBtn: View {
        
        @Environment(\.presentationMode) var presentationMode
        
        var body: some View {
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    Image(systemName: "arrow.left").foregroundStyle(.white)
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    CreateAccScreen(db: DatabaseConfig())
}
