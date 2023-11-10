import SwiftUI

struct LandingScreen: View {
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    Image("NewBgQuizUp")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                    
                    Image("Icon5")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.8)
                        .offset(y: -geometry.size.height * 0.4)
                    
                    VStack(spacing: 30) {
                        NavigationLink(destination: CreateAccScreen(db: DatabaseConfig())) {
                            Text("Skapa konto")
                                .font(.system(size: 16, design: .rounded))
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                                .frame(width: geometry.size.width * 0.8, height: 56)
                                .background(Color("ButtonColor"))
                                .cornerRadius(20)
                        }
                        NavigationLink(destination: LoginScreen(db: DatabaseConfig())) {
                            Text("Logga in")
                                .font(.system(size: 16, design: .rounded))
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                                .frame(width: geometry.size.width * 0.8, height: 56)
                                .background(Color("ButtonColor"))
                                .cornerRadius(20)
                        }
                    }
                    .frame(maxWidth: geometry.size.width, alignment: .center)
                }
            }
        }
        .accentColor(.white)
    }
}

struct LandingScreen_Previews: PreviewProvider {
    static var previews: some View {
        LandingScreen()
    }
}
