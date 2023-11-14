import SwiftUI

struct LeaderboardView: View {
    @Binding var showLeaderboard: Bool
    @EnvironmentObject var db: DatabaseConfig
    @State var isCompleted = false
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.2)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    withAnimation(Animation.easeOut(duration: 0.2)) {
                        showLeaderboard.toggle()
                    }
                }
            VStack {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 320, height: 500)
                    .background(Color("ButtonColor"))
                    .cornerRadius(20)
                    .overlay(
                        VStack {
                            HStack {
                                Spacer()
                                Text("Topplista")
                                    .font(.system(size: 20, design: .rounded))
                                    .fontWeight(.bold)
                                    .foregroundColor(.white).padding(.leading, 25)
                                Spacer()
                                Button(action: {
                                    withAnimation(Animation.easeOut(duration: 0.2)) {
                                        showLeaderboard.toggle()
                                    }
                                }) {
                                    Image(systemName: "xmark").font(.title3).foregroundStyle(.white)
                                }
                            }.padding(.top, 10).padding()
                            ScrollView {
                                VStack {
                                    ForEach(Array(zip(db.users.sorted {$0.score > $1.score }, 1...)), id: \.0.id) { (user, rank) in
                                            Rectangle()
                                                .foregroundColor(.clear)
                                                .frame(width: 270, height: 60)
                                                .background(Color("HomeScreenGradientDark"))
                                                .cornerRadius(20)
                                                .overlay(
                                                    HStack {
                                                        Text("\(rank)").font(.system(.title3, design: .rounded)).foregroundStyle(.white).padding()
                                                        Text(user.selectedIcon).font(.title)
                                                        Text(user.name).font(.system(.title3, design: .rounded))
                                                            .foregroundColor(.white)
                                                        Spacer()
                                                        Text("\(user.score)").font(.system(.title3, design: .rounded))
                                                            .foregroundColor(.white).padding().fontWeight(.bold)
                                                    }
                                                ).padding(2)
                                    }
                                }.onAppear {
                                    db.fetchUsersDetails()
                                }
                            }
                            Spacer()
                        }
                    )
            }
            .background(Color("ProfileBorderColor"))
            .cornerRadius(20)
        }
    }
}

#Preview {
    LeaderboardView(showLeaderboard: .constant(true))
}
