import SwiftUI

struct LandingScreen: View {
    
    var body: some View {
        NavigationView{
            ZStack{
                Image("NewBgQuizUp")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    Image("Icon5").resizable().aspectRatio(contentMode: .fit).frame(width: 300, height: 300).offset(y: -250)
                    ZStack {
                        VStack(spacing: 30) {
                            NavigationLink(destination: CreateAccScreen(db: DatabaseConfig())) {
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
                                            )}
                            NavigationLink(destination: LoginScreen(db: DatabaseConfig() )) {
                                    Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: 270, height: 56)
                                    .background(Color("ButtonColor"))
                                    .cornerRadius(20)
                                    .overlay(
                                        Text("Logga in")
                                        .font(.system(size: 16, design:
                                        .rounded)).fontWeight(.bold)
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(.white)
                        )}
                    }
                }
            }
        }.accentColor(.white)
    }
}

#Preview {
    LandingScreen()
}
