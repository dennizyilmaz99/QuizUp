import SwiftUI

struct ProfileScreen: View {
    var body: some View {
        ZStack {
            Image("ProfileScreenBg2")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                VStack {
                    Circle()
                        .fill(Color("HomeScreenGradientDark"))
                        .frame(width: 110, height: 110)
                        .overlay(
                            Text("🦊").font(.system(size: 70)).position(x: 55, y: 55)
                        )
                        .overlay(
                            Circle()
                                .stroke(Color.white, lineWidth: 4)
                        )
                        .padding(.top, 25)
                    
                    Text("Räven").font(.system(size: 25, design: .rounded)).fontWeight(.bold).foregroundColor(.white).padding(5)
                    Spacer()
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
            Spacer()
                VStack {
                    Text("Poäng").font(.system(size: 18)).fontWeight(.heavy).foregroundColor(.white).padding(.leading, -148).padding(.bottom, 15)
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 300, height: 150)
                        .background(Color("ButtonColor"))
                        .cornerRadius(20)
                        .shadow(radius: 1)                }.frame(maxWidth: .infinity, maxHeight: 300, alignment: .top)
            Spacer()
            VStack(spacing: 25) {
                Text("Inställningar").font(.system(size: 18)).fontWeight(.heavy).foregroundColor(.white).padding(.leading, -148)
                Button(action: {
                    
                }) {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 300, height: 60)
                        .background(Color("ButtonColor"))
                        .cornerRadius(20)
                        .shadow(radius: 1)
                        .overlay(
                            HStack {
                                Text("Konto-inställningar").font(.system(size: 14)).fontWeight(.bold).foregroundColor(.white)
                                Spacer()
                                Image(systemName: "arrow.right").font(.headline)
                            }.padding(20)
                        )
                }
                
                Button(action: {
                    
                }) {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 300, height: 60)
                        .background(Color("ButtonColor"))
                        .cornerRadius(20)
                        .shadow(radius: 1)
                        .overlay(
                            HStack {
                                Text("Byt språk").font(.system(size: 14)).fontWeight(.bold).foregroundColor(.white)
                                Spacer()
                                Image(systemName: "arrow.right").font(.headline)
                            }.padding(20)
                        )
                }
                Button(action: {
                    
                }) {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 300, height: 60)
                        .background(Color("ButtonColor"))
                        .cornerRadius(20)
                        .shadow(radius: 1)
                        .overlay(
                            HStack {
                                Text("Logga ut").font(.system(size: 14)).fontWeight(.bold).foregroundColor(.white)
                                Spacer()
                                Image(systemName: "arrow.right").font(.headline)
                            }.padding(20)
                        )
                }
            }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        }.navigationBarBackButtonHidden(true)
            .navigationTitle("Profil")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: CustomBackBtn())
            .onAppear {
                            let appearance = UINavigationBarAppearance()
                            appearance.configureWithTransparentBackground()
                            appearance.titleTextAttributes = [.foregroundColor: UIColor.white] // Ändra färgen på titeln

                            UINavigationBar.appearance().scrollEdgeAppearance = appearance
                            UINavigationBar.appearance().compactAppearance = appearance
                            UINavigationBar.appearance().standardAppearance = appearance
                        }
    }
}

struct CustomBackBtn: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "arrow.left")
                Spacer()
            }
        }
    }
}

#Preview {
    ProfileScreen()
}
