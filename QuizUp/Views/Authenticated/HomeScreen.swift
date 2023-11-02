import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.homeScreenGradientLight, Color.homeScreenGradientDark]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            ProgressView()
        }
    }
}

struct HomeScreen: View {
    @EnvironmentObject var db: DatabaseConfig
    @State var isNavigatingToGameScreen: Bool = false
    @State var isNavigatingToProfileScreen: Bool = false
    @State var showLeaderboard = false
    @State private var userName: String = ""
    @State private var isLoading = true

    var body: some View {
        ZStack{
            if isLoading {
                LoadingView()
            } else {
                ZStack {
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
                        NavigationLink(destination: ProfileScreen(userName: $userName), isActive: $isNavigatingToProfileScreen) {
                            EmptyView()
                        }
                        Button(action: {
                            isNavigatingToProfileScreen = true
                        }) {
                            Image(systemName: "person.fill").font(.title).foregroundColor(.white)
                        }.padding()
                    }.offset(y: -340)
                    VStack {
                        Text("Välkommen \(userName)!")
                            .font(.system(size: 26, design: .rounded)).fontWeight(.heavy).foregroundColor(.white)
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
            }
            VStack {
                if showLeaderboard {
                    LeaderBoardView(showLeaderboard: $showLeaderboard)
                }
            }
        }
        .onAppear(perform: {
            fetchUserData()
            isLoading = true
        })
    }

    func fetchUserData() {
        if let user = db.currentUser {
            let uid = user.uid
            let docRef = db.db.collection(db.USER_DATA_COLLECTION).document(uid)
            
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    if let data = document.data(){
                        if let name = data["name"] as? String {
                            DispatchQueue.main.async {
                                self.userName = name
                                self.isLoading = false
                            }
                        }
                    }
                } else {
                    print("Dokumentet existerar inte")
                }
            }
        }
    }

}
