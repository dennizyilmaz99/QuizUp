import Foundation
import SwiftUI

struct PopUpView: View {
    

    @Binding var showMyPopup: Bool // Decides if popup should be visible or not
    @State private var selectedDifficulty = "lätt" // By default - easy

    var body: some View {
        VStack(spacing: 70) {
            Text("Välj svårighetsgrad")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.purple)

            Picker("Svårighetsgrad", selection: $selectedDifficulty) { // Update value
                Text("Lätt")
                    .tag("Lätt")
                    
                Text("Svår")
                    .tag("Svår")
            }
            .pickerStyle(SegmentedPickerStyle())
            
            Button("Bekräfta") {
                showMyPopup = false
            }
            .padding()
            .background(Color.purple)
            .foregroundColor(.white)
            .fontWeight(.bold)
            .cornerRadius(10)
        }
        .padding()
        .background(Color.white)
        .frame(width: 350)
        .cornerRadius(10)
    }
}
struct PopUpView_Previews: PreviewProvider {
    static var previews: some View {
        PopUpView(showMyPopup: .constant(true))
    }
}
