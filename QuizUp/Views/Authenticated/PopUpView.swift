import SwiftUI

struct PopUpView: View {
    @Binding var showMyPopup: Bool
    @Binding var selectedCategoryName: String
    @Binding var selectedCategoryNumber: Int
    @State  var selectedDifficultyInPopup = "Easy"
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.3)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    withAnimation(Animation.easeOut(duration: 0.2)) {
                        showMyPopup.toggle()
                    }
                }
            VStack {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 320, height: 300)
                    .background(Color("ButtonColor"))
                    .cornerRadius(20)
                    .overlay(
                        VStack {
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
                            }.padding(.top, 10).padding()
                            Spacer()
                            Picker("Svårighetsgrad", selection: $selectedDifficultyInPopup) {
                                Text("Lätt")
                                    .tag("Easy")
                                
                                Text("Svår")
                                    .tag("Hard")
                            }
                            .pickerStyle(SegmentedPickerStyle()).background(.purple).cornerRadius(8).padding()
                            Spacer()
                            NavigationLink(destination: QuizGameScreen( selectedCategoryNumber: $selectedCategoryNumber, selectedCategoryName: $selectedCategoryName, selectedDifficultyInPopup: $selectedDifficultyInPopup),
                                label: {
                                Rectangle()
                                    .frame(width: 120, height: 56)
                                    .foregroundColor(.clear)
                                    .background(Color("ButtonColor"))
                                    .cornerRadius(10)
                                    .shadow(radius: 10)
                                    .overlay(
                                        Text("Bekräfta").foregroundStyle(.white).font(.system(size: 15, design: .rounded)).fontWeight(.bold)
                                    ).padding(.bottom, 20)
                            })
                        }
                    )
            }
            .background(Color("ProfileBorderColor"))
        }
    }
}

struct PopUpView_Previews: PreviewProvider {
    
    static var previews: some View {
        PopUpView(showMyPopup: .constant(true), selectedCategoryName: .constant("Sport"), selectedCategoryNumber: .constant(21))
    }
}

