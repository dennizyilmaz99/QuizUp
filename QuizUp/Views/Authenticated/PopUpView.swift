import Foundation
import SwiftUI


struct PopUpView: View {
    
    
    @Binding var showMyPopup: Bool // Decides if popup should be visible or not
    @Binding var selectedCategoryName: String
    @Binding var selectedCategoryNumber: Int
    @State  var selectedDifficultyInPopup = "Easy" // By default - easy
    
    var body: some View {
        VStack(spacing: 70) {
            Text("Välj svårighetsgrad")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.purple)
            
            Picker("Svårighetsgrad", selection: $selectedDifficultyInPopup) { // Update value
                Text("Easy")
                    .tag("easy")
                
                Text("Hard")
                    .tag("hard")
            }
            .pickerStyle(SegmentedPickerStyle())
            
            NavigationLink(destination: QuizGameScreen( selectedCategoryNumber: $selectedCategoryNumber, selectedCategoryName: $selectedCategoryName, selectedDifficultyInPopup: $selectedDifficultyInPopup),
                 label: {
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
            PopUpView(showMyPopup: .constant(true), selectedCategoryName: .constant("Sport"), selectedCategoryNumber: .constant(21))
    }
       

}
