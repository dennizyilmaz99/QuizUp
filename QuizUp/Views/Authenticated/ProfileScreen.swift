import SwiftUI

struct LoadingView: View {
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.homeScreenGradientLight, Color.homeScreenGradientDark]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            ProgressView().controlSize(.large).tint(.white)
        }.navigationBarBackButtonHidden(true)
    }
}

struct ProfileScreen: View {
    @EnvironmentObject var db: DatabaseConfig
    @State private var showingAlert = false
    var totalValue: Int {
        return db.historiaValue + db.sportValue + db.geografiValue + db.teknikValue
    }
    var body: some View {
        ZStack {
            if !db.didFetchData {
                LoadingView()
            } else {
                    ZStack {
                        Image("ProfileScreenBg2")
                            .resizable()
                            .scaledToFill()
                            .edgesIgnoringSafeArea(.all)
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        ScrollView(.vertical) {
                        VStack {
                            Circle()
                                .fill(Color("HomeScreenGradientDark"))
                                .frame(width: 110, height: 110)
                                .shadow(radius: 10)
                                .overlay(
                                    Text(db.selectedIcon).font(.system(size: 70)).position(x: 55, y: 55)
                                )
                                .overlay(
                                    Circle()
                                        .stroke(Color("ButtonColor"), lineWidth: 4)
                                )
                                .padding(.top, 25)
                            
                            Text("\(db.userName)").font(.system(size: 25, design: .rounded)).fontWeight(.bold).foregroundColor(.white).padding(5)
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
                                .shadow(radius: 1)
                                .overlay(
                                    HStack {
                                        VStack {
                                            Text("Totalt").font(.system(size: 15, design: .rounded))
                                            Text("\(totalValue)").font(.system(size: 30, design: .rounded)).fontWeight(.bold)
                                        }.foregroundColor(.white)
                                        Spacer()
                                        VStack {
                                            Line().stroke(Color.white, lineWidth: 2).frame(width: 1, height: 100)
                                        }
                                        Spacer()
                                        VStack {
                                            Text("Historia \(db.historiaValue)").font(.system(size: 15, design: .rounded))
                                            Text("Geografi \(db.geografiValue)").font(.system(size: 15, design: .rounded))
                                            Text("Sport \(db.sportValue)").font(.system(size: 15, design: .rounded))
                                            Text("Teknik \(db.teknikValue)").font(.system(size: 15, design: .rounded))
                                        }.multilineTextAlignment(.leading).foregroundColor(.white)
                                    }.padding(50)
                                )
                        }.frame(maxWidth: .infinity, maxHeight: 300, alignment: .top)
                        Spacer()
                        VStack(spacing: 25) {
                            Text("Inställningar").font(.system(size: 18)).fontWeight(.heavy).foregroundColor(.white).padding(.leading, -148)
                            Button(action: {
                                showingAlert = true
                            }) {
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: 300, height: 75)
                                    .background(Color("ButtonColor"))
                                    .cornerRadius(20)
                                    .shadow(radius: 1)
                                    .overlay(
                                        HStack {
                                            Text("Logga ut").font(.system(size: 14)).fontWeight(.bold).foregroundColor(.white)
                                            Spacer()
                                            Image(systemName: "arrow.right").font(.headline).foregroundStyle(.white)
                                        }.padding(20)
                                    )
                            }
                        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom).padding()
                    }
                }
            }
        }.navigationBarBackButtonHidden(true)
            .navigationBarTitle("Profil")
            .navigationBarColor(backgroundColor: .clear, titleColor: .white)

            .navigationBarItems(leading: CustomBackBtn())
            .alert(isPresented: $showingAlert) {
                Alert(
                    title: Text("Logga ut"),
                    message: Text("Är du säker att du vill logga ut?"),
                    primaryButton: .default(Text("Ja")) {
                        db.handleLogOut()
                        db.didFetchData = false
                    },
                    secondaryButton: .destructive(Text("Avbryt"))
                )
            }.onAppear(perform: {
                db.fetchProfileUserData()
        })
    }
}

struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        return path
    }
}

struct CustomBackBtn: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "arrow.left").foregroundStyle(.white)
                Spacer()
            }
        }
    }
}

struct NavigationBarModifier: ViewModifier {

    var backgroundColor: UIColor?
    var titleColor: UIColor?

    init(backgroundColor: UIColor?, titleColor: UIColor?) {
        self.backgroundColor = backgroundColor
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = backgroundColor
        coloredAppearance.titleTextAttributes = [.foregroundColor: titleColor ?? .white]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: titleColor ?? .white]

        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
    }

    func body(content: Content) -> some View {
        ZStack{
            content
            VStack {
                GeometryReader { geometry in
                    Color(self.backgroundColor ?? .clear)
                        .frame(height: geometry.safeAreaInsets.top)
                        .edgesIgnoringSafeArea(.top)
                    Spacer()
                }
            }
        }
    }
}

extension View {

    func navigationBarColor(backgroundColor: UIColor?, titleColor: UIColor?) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor, titleColor: titleColor))
    }

}
    

#Preview {
    ProfileScreen()
}

