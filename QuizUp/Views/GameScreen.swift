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
                Text("Välj en kategori")
                    .font(.system(size: 36, design:
                            .rounded)).fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .offset(y: -300)
                    .blur(radius: showMyPopup ? 5 : 0) // If PopupView is true -> blur component
                
                
                    VStack(spacing: 40) {
                        // To render all categories in our array
                        ForEach(categories) { category in
                            Button(action: { // Creates a button for each category
                                self.showMyPopup = true
                                   
                            }) { // Creates an instance of ButtonView and passes categorieName as a parameter
                                ButtonView(categorieName: category.categorieName)
                            }
                        }
                    }
                    .blur(radius: showMyPopup ? 5 : 0)
                    .padding()
                    .offset(y: 50)
                
                if showMyPopup {
                    PopUpView(showMyPopup: $showMyPopup)
               }
            }.frame(maxWidth: .infinity, maxHeight: .infinity).background(LinearGradient(gradient: Gradient(colors: [Color.homeScreenGradientLight, Color.homeScreenGradientDark]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all))
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
                GameScreen()
        }
    }
    
    struct ButtonView: View {  // Creates all components that represents each category
        
        let categorieName: String
        
        var body: some View {
           
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 325, height: 90)
                    .background(Color("ButtonColor"))
                    .cornerRadius(20)
                    .shadow(radius: 15, x: -1, y: -3)
                    .overlay(
                        Text(categorieName)
                            .font(.system(size: 23, design: .rounded))
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                    )
            
        }
    }
}
