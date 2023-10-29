import Foundation
import SwiftUI

struct PopUpView: View {
    
    
    @Binding var showMyPopup: Bool // Decides if popup should be visible or not
    @State private var selectedDifficulty = "Lätt" // By default - easy
    
    var body: some View {
        VStack(spacing: 70) {
            Text("Välj svårighetsgrad")
                .font(.system(size: 20, design: .rounded))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.top, 20)
            
            Picker("Svårighetsgrad", selection: $selectedDifficulty) { // Update value
                Text("Lätt")
                    .tag("Lätt").foregroundColor(.white)
                
                Text("Svår")
                    .tag("Svår").foregroundColor(.white)
            }
            .pickerStyle(SegmentedPickerStyle())
            .background(.purple)
            .cornerRadius(6)
            .shadow(color: Color.black.opacity(0.2), radius: 20)
            
            Button(action: {
                showMyPopup.toggle()
            }
            ) {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 180, height: 50)
                    .background(Color("ButtonColor"))
                    .cornerRadius(20)
                    .shadow(color: Color.black.opacity(0.3), radius: 35)
                    .overlay(
                        Text("Bekräfta").font(.system(size: 15, design: .rounded)).fontWeight(.bold).foregroundColor(.white)
                    ).padding(.bottom, 20)
            }
        }
        .padding()
        .background(Color("ProfileBorderColor"))
        .frame(width: 350)
        .cornerRadius(20)
        .shadow(radius: 20)
    }
}
struct PopUpView_Previews: PreviewProvider {
    static var previews: some View {
        PopUpView(showMyPopup: .constant(true))
    }
}
