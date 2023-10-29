import Foundation
import SwiftUI
import Alamofire

struct PopUpView: View {
    
   /* func fetchQuestionsAndAnswers() {
     
      
        do {
            let request = try AF.request("https://opentdb.com/api.php?amount=10&category=21&difficulty=\(selectedDifficultyInPopup)&type=multiple&encode=url3986")
            request.responseJSON { response in
                switch response.result {
                case .success(let data):
                    print(data)
                case .failure(let error):
                    print(error)
                }
            }
        } catch {
            print(error)
        }
    } */
    
    
    @Binding var showMyPopup: Bool // Decides if popup should be visible or not
    @Binding var selectedCategory: String
    @State private var selectedDifficultyInPopup = "Easy" // By default - easy
    
    var body: some View {
        VStack(spacing: 70) {
            Text("Välj svårighetsgrad")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.purple)
            
            Picker("Svårighetsgrad", selection: $selectedDifficultyInPopup) { // Update value
                Text("Easy")
                    .tag("Easy")
                
                Text("Hard")
                    .tag("Hard")
            }
            .pickerStyle(SegmentedPickerStyle())
            
            NavigationLink(destination: QuizGameScreen(isDifficult: selectedDifficultyInPopup, myCategory: selectedCategory), label: {
                Text("Bekräfta").padding()
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .cornerRadius(10)
               
            }).onTapGesture {
                //fetchQuestionsAndAnswers()
               
            }
            
        }
        .padding()
        .background(Color.white)
        .frame(width: 350)
        .cornerRadius(10)
    }
}
    
    struct PopUpView_Previews: PreviewProvider {
        
        static var previews: some View {
            PopUpView(showMyPopup: .constant(true), selectedCategory: .constant("Din valda kateogri"))
    }
       

}


