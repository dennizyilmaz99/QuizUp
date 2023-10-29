import SwiftUI

struct GameScreen: View {
    
    @State var showMyPopup = false
    
    // An array of categories a user can select between. Every category is a object of CategoriesData
    let categories: [CategoriesData] =
    [
        CategoriesData(categorieName: "Sport"),
        CategoriesData(categorieName: "Historia"),
        CategoriesData(categorieName: "Geografi"),
        CategoriesData(categorieName: "Teknik")
    ]
    
    var body: some View {
        NavigationView{
            ZStack{
                ZStack {
                    Text("Välj en kategori")
                        .font(.system(size: 30, design:
                                .rounded)).fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .offset(y: -300)
                    VStack(spacing: 40) {
                        // To render all categories in our array
                        ForEach(categories) { category in
                            Button(action: { // Creates a button for each category
                                withAnimation {
                                    self.showMyPopup.toggle()
                                }
                            }) { // Creates an instance of ButtonView and passes categorieName as a parameter
                                ButtonView(categorieName: category.categorieName)
                            }
                        }
                    }
                    .padding()
                    .offset(y: 50)
                }.frame(maxWidth: .infinity, maxHeight: .infinity).background(LinearGradient(gradient: Gradient(colors: [Color.homeScreenGradientLight, Color.homeScreenGradientDark]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all))
                .blur(radius: showMyPopup ? 1.5 : 0).background(showMyPopup ? Color.black.opacity(1) : Color.clear )
                if showMyPopup {
                    PopUpView(showMyPopup: $showMyPopup)
                }
            }
            
        }.navigationBarBackButtonHidden(true).navigationBarItems(leading: CustomBackBtn())
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
    
    struct ButtonView: View {  // Creates all components that represents each category
        
        let categorieName: String
        
        var body: some View {
            
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 310, height: 75)
                .background(Color("ButtonColor"))
                .cornerRadius(20)
                .overlay(
                    Text(categorieName)
                        .font(.system(size: 20, design: .rounded))
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                )
            
        }
    }
}

#Preview {
    GameScreen()
}
