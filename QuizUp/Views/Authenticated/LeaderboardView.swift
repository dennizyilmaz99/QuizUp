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
                                    ForEach(db.users, id: \.id) { user in
                                            Rectangle()
                                                .foregroundColor(.clear)
                                                .frame(width: 270, height: 50)
                                                .background(.black)
                                                .cornerRadius(20)
                                                .overlay(
                                                    HStack {
                                                        Spacer()
                                                        Text(user.name)
                                                            .foregroundColor(.white)
                                                        Spacer()
                                                        Text("\(user.score)")
                                                            .foregroundColor(.white)
                                                    }
                                                )
                                                .padding(2)
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
