import SwiftUI

struct MenuPopUpView: View {
    @Binding var showMenu: Bool
    @Binding var navigatingToHomeScreen: Bool
    
    var body: some View {
        GeometryReader { geometry in
        ZStack {
            Color.black.opacity(0.2)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    withAnimation(Animation.easeOut(duration: 0.2)) {
                        showMenu.toggle()
                    }
                }
            VStack {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: geometry.size.width * 0.7, height: geometry.size.height * 0.3)
                    .background(Color("ButtonColor"))
                    .cornerRadius(20)
                    .overlay(
                        VStack(spacing: 25) {
                            HStack {
                                Spacer()
                                Button(action: {
                                    showMenu = false  // Stäng menyn
                                }) {
                                    Image(systemName: "xmark").font(.title3).foregroundStyle(.white).padding(.trailing, 30)
                                }
                            }
                            Button(action: {
                                showMenu = false  // Stäng menyn
                            }) {
                                Rectangle()
                                    .frame(width: geometry.size.width * 0.4, height: 50)
                                    .foregroundStyle(Color("ButtonColor"))
                                    .cornerRadius(10)
                                    .shadow(color: Color.black.opacity(0.2), radius: 10)
                                    .overlay(
                                        Text("Återuppta spel").foregroundStyle(.white)
                                    )
                            }
                            Button(action: {
                                withAnimation(.easeOut){
                                    navigatingToHomeScreen = true
                                }
                                // Sätt flaggan för att navigera till HomeScreen
                                showMenu = false
                            }) {
                                Rectangle()
                                    .frame(width: geometry.size.width * 0.4, height: 50)
                                    .foregroundStyle(Color("ButtonColor"))
                                    .cornerRadius(10)
                                    .shadow(color: Color.black.opacity(0.2), radius: 10)
                                    .overlay(
                                        Text("Avsluta spel").foregroundStyle(.white)
                                    )
                            }
                        }
                    )
            }
            .background(Color("ProfileBorderColor"))
            .cornerRadius(20)
        }
    }
}
}

