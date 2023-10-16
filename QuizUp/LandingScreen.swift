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
                    Image("QuizUpIcon5").resizable().aspectRatio(contentMode: .fit).frame(width: 300, height: 300).offset(y: -280)
                    
                        ZStack {
                                Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 350, height: 270)
                                .background(.white)
                                .cornerRadius(20)
                            VStack{
                                Text("Kul att se dig!\n\nUtforska våra unika och spännande frågor.")
                                    .font(.system(size: 20, design: .rounded)).fontWeight(.bold)
                                    .foregroundColor(.black)
                            }.offset(x: -20,y: -60)
                                Button(action: {
                                    
                                }, label: {
                                    NavigationLink(destination: CreateAccScreenView()) {
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
                                }).offset(y: 40)
                            HStack {
                                Text("Har du redan ett konto?")
                                    .font(.system(size: 15.5, design: .rounded)).fontWeight(.medium)
                                Button(action: {
                                    
                                }, label: {
                                    NavigationLink(destination: LoginScreen()) {
                                        Text("Logga in här")
                                            .font(.system(size: 15.5, design: .rounded)).fontWeight(.bold).foregroundColor(Color("ButtonColor"))
                                    }
                                })
                            }.offset(y: 110).frame(width: 270)
                        }
            }
        }
    }
}

struct LandingScreen_Previews: PreviewProvider {
    static var previews: some View {
        LandingScreen()
    }
}
