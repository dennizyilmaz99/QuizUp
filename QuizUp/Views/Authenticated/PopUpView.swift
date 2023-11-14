import Foundation
import SwiftUI

struct PopUpView: View {
    
    @Binding var showMyPopup: Bool
    @Binding var selectedCategoryName: String
    @Binding var selectedCategoryNumber: Int
    @State  var selectedDifficultyInPopup = "easy"
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black.opacity(0.2)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation(Animation.easeOut(duration: 0.2)) {
                            showMyPopup.toggle()
                        }
                    }
                VStack(spacing: 70) {
                    HStack {
                        Spacer()
                        Text("Välj svårighetsgrad")
                            .font(.system(size: 20, design: .rounded))
                            .fontWeight(.bold)
                            .foregroundColor(.white).padding(.leading, 25)
                        Spacer()
                        Button(action: {
                            withAnimation(Animation.easeOut(duration: 0.2)) {
                                showMyPopup.toggle()
                            }
                        }) {
                            Image(systemName: "xmark").font(.title3).foregroundStyle(.white)
                        }
                    }.padding(.top, 10)
                    Picker("Svårighetsgrad", selection: $selectedDifficultyInPopup) {
                        Text("Lätt")
                            .tag("easy")
                        
                        Text("Svår")
                            .tag("hard")
                    }
                    .background(.purple)
                    .cornerRadius(8)
                    .pickerStyle(SegmentedPickerStyle())
                    
                    NavigationLink(destination: QuizGameScreen( selectedCategoryNumber: $selectedCategoryNumber, selectedCategoryName: $selectedCategoryName, selectedDifficultyInPopup: $selectedDifficultyInPopup),
                                   label: {
                        Text("Bekräfta").padding()
                            .background(Color("ButtonColor"))
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                    })
                }
                .padding()
                .background(Color("ButtonColor"))
                .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.5) // FÖRÄNDRING
                .position(x: geometry.size.width * 0.5, y: geometry.size.height * 0.5) // FÖRÄNDRING
                .cornerRadius(10)
            }
        }
    }
}

struct PopUpView_Previews: PreviewProvider {
    static var previews: some View {
        PopUpView(showMyPopup: .constant(true), selectedCategoryName: .constant("Sport"), selectedCategoryNumber: .constant(21))
    }
}
