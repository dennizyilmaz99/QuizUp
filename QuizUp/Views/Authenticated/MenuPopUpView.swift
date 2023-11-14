import SwiftUI

struct MenuPopUpView: View {
    @Binding var showMenu: Bool
    @Binding var navigatingToHomeScreen: Bool
    
    var body: some View {
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
                    .frame(width: 200, height: 200)
                    .background(Color("ButtonColor"))
                    .cornerRadius(20)
                    .overlay(
                        VStack {
                            Button(action: {
                                showMenu = false  // Stäng menyn
                            }) {
                                Rectangle()
                                    .frame(width: 100, height: 50)
                                    .foregroundStyle(Color("ButtonColor"))
                                    .shadow(radius: 5)
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
                                    .frame(width: 100, height: 50)
                                    .foregroundStyle(Color("ButtonColor"))
                                    .shadow(radius: 5)
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

