import SwiftUI

struct LoginScreen: View {
    
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
                    Text("Logga in")
                        .font(.system(size: 36, design: .rounded)).fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white).offset(y: -270)
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 351, height: 310)
                        .background(Color("ButtonColor"))
                        .cornerRadius(20)
                        .overlay(
                            VStack (spacing: 25){
                                // Maybe att textFieldStyle to email
                                TextField("", text: $db.email, prompt: Text("E-post").foregroundColor(Color.color5).font(.system(size: 15)))
                                    .padding(8)
                                    .background(RoundedRectangle(cornerRadius: 10).stroke(.purple, lineWidth: 5))
                                    .background(Color(.color4))
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                // Maybe change to secureField instead for password
                                SecureField("", text: $db.password, prompt: Text("Lösenord").foregroundColor(Color.color5).font(.system(size: 15)))
                                    .padding(8)
                                    .background(RoundedRectangle(cornerRadius: 10).stroke(.purple, lineWidth: 5))
                                    .background(Color(.color4))
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                NavigationLink(destination: HomeScreen(), isActive: $isNavigating) {
                                    EmptyView()
                                }
                                Button(action: {
                                    if db.validateLogInFields() {
                                        db.logInUser(email: db.email, password: db.password) { success, message in
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
                                        showAlert = true
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
            }.navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: CustomBackBtn())
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Fel"), message: Text(db.alertMessage), dismissButton: .default(Text("OK")))
                }
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
    func showAlert(message: String) {
        showAlert = true
        db.alertMessage = message
    }
}

#Preview {
    LoginScreen(db: DatabaseConfig())
}
