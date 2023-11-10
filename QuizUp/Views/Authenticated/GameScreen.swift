import SwiftUI
import Alamofire

struct GameScreen: View {
    
    @State var showMyPopup = false
    //@State private var questions: [Question] = []
    @State var selectedCategoryNumber = 0 // Lagra dne valda kategorin
  //  @State private var selectedDifficulty: String = "" // Lagra den valda svårighetsgraden
   
    @State var selectedCategoryName = ""
    
    // An array of categories a user can select between. Every category is a object of CategoriesData
    let categories: [CategoriesData] = 
    [
    CategoriesData(categorieName: "Sport", categorieNumber: 21),
    CategoriesData(categorieName: "Historia", categorieNumber: 23),
    CategoriesData(categorieName: "Geografi", categorieNumber: 22),
    CategoriesData(categorieName: "Teknik", categorieNumber: 18)
    ]
    
    var body: some View {
        NavigationView{
            ZStack{
                LinearGradient(gradient: Gradient(colors: [Color.homeScreenGradientLight, Color.homeScreenGradientDark]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
    
                Text("Välj en kategori")
                    .font(.system(size: 33, design:
                            .rounded)).fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .offset(y: -300)
                    VStack(spacing: 40) {
                        // To render all categories in our array
                        ForEach(categories) { category in
                            Button(action: { // Creates a button for each category
                              //  self.selectedCategory = category.categorieName
                                withAnimation(Animation.easeOut(duration: 0.2)) {
                                showMyPopup.toggle()
                            }
                                self.selectedCategoryNumber = category.categorieNumber
                                self.selectedCategoryName = category.categorieName
                            }) { // Creates an instance of ButtonView and passes categorieName as a parameter
                                
                                ButtonView(categorieName: category.categorieName)
                            }
                        }
                    }
                    .padding()
                    .offset(y: 50)
                
                if showMyPopup {
                 PopUpView(showMyPopup: $showMyPopup, selectedCategoryName: $selectedCategoryName, selectedCategoryNumber: $selectedCategoryNumber )
               }
            }
        }.navigationBarBackButtonHidden(true).navigationBarItems(leading: CustomBackBtn())
    }
    
   
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            GameScreen(selectedCategoryNumber: 21, selectedCategoryName: "Sport")
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
    
  
    
    struct ButtonView: View {  // Creates all components that represents each category
        
        let categorieName: String
        
        var body: some View {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 320, height: 80)
                    .background(Color("ButtonColor"))
                    .cornerRadius(20)
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

