import SwiftUI

struct LeaderBoardView: View {
    @Binding var showLeaderboard: Bool
    
    var body: some View {
        VStack {
            
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 320, height: 500)
                .background(Color("ButtonColor"))
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.3), radius: 35)
                .overlay(
                    VStack {
                        HStack {
                            
                            Spacer()
                            Text("Leaderboard")
                                .font(.system(size: 20, design: .rounded))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            Spacer()
                            Button(action: {
                                withAnimation {
                                    showLeaderboard.toggle()
                                }
                            }) {
                                Text("X")
                            }
                        }.padding(.top, 10).padding()
                        Spacer()
                    }
                )
        }
        .background(Color("ProfileBorderColor"))
        .cornerRadius(20)
        .shadow(radius: 20)
    }
}

#Preview {
    LeaderBoardView(showLeaderboard: .constant(true))
}

