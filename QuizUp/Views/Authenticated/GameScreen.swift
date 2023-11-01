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
<<<<<<< HEAD:QuizUp/Views/GameScreen.swift
        CategoriesData(categorieName: "Sport"),
        CategoriesData(categorieName: "Historia"),
        CategoriesData(categorieName: "Geografi"),
        CategoriesData(categorieName: "Teknik")
=======
    CategoriesData(categorieName: "Sport", categorieNumber: 21),
    CategoriesData(categorieName: "Historia", categorieNumber: 23),
    CategoriesData(categorieName: "Geografi", categorieNumber: 22),
    CategoriesData(categorieName: "Teknik", categorieNumber: 18)
>>>>>>> origin/main:QuizUp/Views/Authenticated/GameScreen.swift
    ]
    
 /*   let categoryIDs: [String: Int] = [
           "Sport": 21,
           "Historia": 23,
           "Geografi": 22,
           "Teknik": 18
       ] */
    
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
<<<<<<< HEAD:QuizUp/Views/GameScreen.swift
                                withAnimation {
                                    self.showMyPopup.toggle()
                                }
=======
                              //  self.selectedCategory = category.categorieName
                                self.showMyPopup = true
                                self.selectedCategoryNumber = category.categorieNumber
                                self.selectedCategoryName = category.categorieName
>>>>>>> origin/main:QuizUp/Views/Authenticated/GameScreen.swift
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
<<<<<<< HEAD:QuizUp/Views/GameScreen.swift
                    PopUpView(showMyPopup: $showMyPopup)
                }
=======
                 PopUpView(showMyPopup: $showMyPopup, selectedCategoryName: $selectedCategoryName, selectedCategoryNumber: $selectedCategoryNumber )
               }
>>>>>>> origin/main:QuizUp/Views/Authenticated/GameScreen.swift
            }
            
        }.navigationBarBackButtonHidden(true).navigationBarItems(leading: CustomBackBtn())
    }
    
<<<<<<< HEAD:QuizUp/Views/GameScreen.swift
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
=======
   
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            GameScreen(selectedCategoryNumber: 21, selectedCategoryName: "Sport")
>>>>>>> origin/main:QuizUp/Views/Authenticated/GameScreen.swift
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

<<<<<<< HEAD:QuizUp/Views/GameScreen.swift
#Preview {
    GameScreen()
}
=======
>>>>>>> origin/main:QuizUp/Views/Authenticated/GameScreen.swift
