import SwiftUI

struct HomeScreen: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @EnvironmentObject var db: DatabaseConfig
    @State var isNavigatingToGameScreen: Bool = false
    @State var isNavigatingToProfileScreen: Bool = false
    @State var showLeaderboard = false
    
    var body: some View {
        GeometryReader { geometry in
          ZStack {
              if !db.didFetchData {
                  LoadingView()
              } else {
                  ZStack {
                      LinearGradient(gradient: Gradient(colors: [Color.homeScreenGradientLight, Color.homeScreenGradientDark]), startPoint: .topLeading, endPoint: .bottomTrailing)
                          .edgesIgnoringSafeArea(.all)
                      VStack {
                              Rectangle()
                              .frame(width: geometry.size.width, height: geometry.size.height * 0.17)
                                  .foregroundStyle(Color("HomeScreenGradientDark"))
                                  .edgesIgnoringSafeArea(.all)
                                  .shadow(radius: 10)
                                  .overlay(
                                      VStack {
                                          HStack {
                                              Button(action: {
                                                  withAnimation(Animation.easeOut(duration: 0.2)) {
                                                      showLeaderboard.toggle()
                                                  }
                                              }) {
                                                  Image("podium-icon1").resizable().frame(width: 30, height: 25)
                                              }.padding()
                                              
                                              Spacer()
                                              Image("Icon5").resizable().aspectRatio(contentMode: .fit).frame(width: 175, height: 175)
                                              Spacer()
                                              NavigationLink(destination: ProfileScreen(), isActive: $isNavigatingToProfileScreen) {
                                                  EmptyView()
                                              }
                                              Button(action: {
                                                  isNavigatingToProfileScreen = true
                                              }) {
                                                  Image(systemName: "person.fill").font(.title).foregroundColor(.white)
                                              }.padding()
                                          }.padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                                          Spacer()
                                      }
                                  )
                          Spacer()
                      }.edgesIgnoringSafeArea(.all)
                      VStack {
                          Text("Välkommen \(db.userName)!")
                              .font(.system(size: 24, design: .rounded)).fontWeight(.heavy).foregroundColor(.white)
                              .frame(maxWidth: geometry.size.width, alignment: .leading).padding()
                      }.offset(y: -geometry.size.height * 0.3)
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
                      }.offset(y: -geometry.size.height * 0.1)
                  }.navigationBarBackButtonHidden(true)
              }
              VStack {
                  if showLeaderboard {
                      LeaderboardView(showLeaderboard: $showLeaderboard).environmentObject(db)
                  }
              }
          }
        }
        .onAppear(perform: {
            db.fetchCurrentUserDetails()
            db.fetchUsersDetails()
            print(db.didFetchData)
        })
    }
}

#Preview {
    HomeScreen()
}
