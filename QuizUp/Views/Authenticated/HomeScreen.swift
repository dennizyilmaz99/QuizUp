import SwiftUI

struct HomeScreen: View {
    
    @EnvironmentObject var db: DatabaseConfig
<<<<<<< HEAD:QuizUp/Views/HomeScreen.swift
    @State var isNavigatingToGameScreen: Bool = false
    @State var isNavigatingToProfileScreen: Bool = false
    @State var showLeaderboard = false
    
    var body: some View {
        ZStack{
            ZStack {
=======
    @State var isNavigating: Bool = false
   
    
    var body: some View {
            ZStack{
>>>>>>> origin/main:QuizUp/Views/Authenticated/HomeScreen.swift
                LinearGradient(gradient: Gradient(colors: [Color.homeScreenGradientLight, Color.homeScreenGradientDark]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                HStack {
                    Button(action: {
                        withAnimation {
                            showLeaderboard.toggle()
                        }
                    }) {
                        Image(systemName: "chart.bar.fill").font(.title2).foregroundColor(.white)
                    }.padding()
                    
                    Spacer()
                    Image("Icon5").resizable().aspectRatio(contentMode: .fit).frame(width: 175, height: 175)
                    Spacer()
<<<<<<< HEAD:QuizUp/Views/HomeScreen.swift
                    NavigationLink(destination: ProfileScreen(), isActive: $isNavigatingToProfileScreen) {
                        EmptyView()
                    }
                    Button(action: {
                        isNavigatingToProfileScreen = true
                    }) {
                        Image(systemName: "person.fill").font(.title).foregroundColor(.white)
                    }.padding()
                }.offset(y: -340)
                VStack {
                    Text("Välkommen").font(.system(size: 26, design:
                            .rounded)).fontWeight(.heavy).foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading).padding()
                }.offset(y: -230)
                VStack {
                    NavigationLink(destination: GameScreen(), isActive: $isNavigatingToGameScreen) {
                        EmptyView()
                    }
                    Button(action: {
                        isNavigatingToGameScreen = true
                    }) {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 270, height: 150)
                            .background(Color("ButtonColor"))
                            .cornerRadius(20)
                            .shadow(radius: 1)
                            .overlay(
                                VStack {
                                    Text("Spela")
                                        .font(.system(size: 25, design: .rounded))
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading).padding(17)
                                    Text("Spela mot dig själv och testa din kunskap.")
                                        .multilineTextAlignment(.leading)
                                        .font(.system(size: 15, design: .rounded))
                                        .frame(maxWidth: .infinity,
                                               maxHeight: .infinity, alignment: .bottomLeading).padding(17).foregroundColor(.white)
                                }
                            )
                    }
                }.offset(y: -80)
            }.navigationBarBackButtonHidden(true).blur(radius: showLeaderboard ? 1.5 : 0).background(showLeaderboard ? Color.black.opacity(1) : Color.clear )
            VStack {
                if showLeaderboard {
                    LeaderBoardView(showLeaderboard: $showLeaderboard)
                }
            }
        }
    }
}

#Preview {
    HomeScreen()
=======
                    Button(action: {
                        isNavigating = true
                    }) {
                        Image(systemName: "gearshape.fill").font(.title).foregroundColor(.white)
                    }.padding()
                }.offset(y: -340)
                VStack {
                    Text("Välkommen").font(.system(size: 30, design:
                            .rounded)).fontWeight(.heavy).foregroundColor(.white)
                }.offset(y: -250)
                VStack {
                    NavigationLink(destination: GameScreen(), label:  {
                        Rectangle()
                           .foregroundColor(.clear)
                           .frame(width: 270, height: 200)
                          .background(Color("ButtonColor"))
                          .cornerRadius(20)
                          .shadow(radius: 4)
                          .overlay(
                                Text("Spela")
                                    .font(.system(size: 25, design: .rounded))
                                    .fontWeight(.bold)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.white)
                            )
                        
                    })
                   
                }
            }
        }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen().environmentObject(DatabaseConfig())
    }
    
>>>>>>> origin/main:QuizUp/Views/Authenticated/HomeScreen.swift
}
