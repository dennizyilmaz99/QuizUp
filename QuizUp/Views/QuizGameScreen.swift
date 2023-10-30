//
//  QuizGameScreen.swift
//  QuizUp
//
//  Created by Aran Ali on 2023-10-25.
//

import Foundation
import SwiftUI
import Alamofire

struct QuizGameScreen: View {
    
   // var isDifficult: String // Hämtar värdet av svårighetsgraden användaren har valt i PopUpView
  //  var myCategory: String // Hämtar värdet av kateogrin som användaren valt i GameScreen
    
    @StateObject var api = TriviaAPI()
    @Binding var selectedCategoryNumber: Int
    @Binding var selectedCategoryName: String
    @State var currentQuestionIndex = 0
    @Binding var selectedDifficultyInPopup: String
    
   // @State var questions: [Question] = []

    
    var body: some View {
    
        ZStack{
            
            Image("NewBgQuizUp")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight:.infinity)
            VStack(alignment: .leading){
                Text("QuizUp")
                    .font(.system(size: 36, design:
                            .rounded)).fontWeight(.bold)
                    .foregroundColor(.white)
                    .offset(x: -100, y: -350)
            }
            Text("1 out of 0")
                .font(.system(size: 23, design:
                        .rounded)).fontWeight(.bold)
                .foregroundColor(.white)
                .offset(x: 100, y: -300)
            
            if !api.QnAData.isEmpty {
                Text(api.QnAData[currentQuestionIndex].question)
                    .font(.system(size: 23, design:
                    .rounded)).fontWeight(.bold)
                    .foregroundColor(.white)
                    .offset(y: -200)
            } else {
                Text("Loading...")
                    .font(.system(size: 23, design:
                    .rounded)).fontWeight(.bold)
                    .foregroundColor(.white)
                    .offset(y: -200)
            }
           
            
            VStack{
                Button(action: {
                    print("Du har valt svar A")
                }) {
                    Text("A")
                        .font(.system(size: 20, design: .rounded))
                        .foregroundColor(.purple)
                        .frame(width: 300, alignment: .leading)
                        .padding()
                        .background(Color.white)
                        .fontWeight(.bold)
                        .cornerRadius(10)
                        
                }
               
                
                Button(action: {
                    
                }, label: {
                    Text("B")
                        .font(.system(size: 20, design: .rounded))
                        .foregroundColor(.purple)
                        .frame(width: 300, alignment: .leading)
                        .padding()
                        .background(Color.white)
                        .fontWeight(.bold)
                        .cornerRadius(10)
                })
                Button(action: {
                    
                }, label: {
                    Text("C")
                        .font(.system(size: 20, design: .rounded))
                        .foregroundColor(.purple)
                        .frame(width: 300, alignment: .leading)
                        .padding()
                        .background(Color.white)
                        .fontWeight(.bold)
                        .cornerRadius(10)
                })
                Button(action: {
                    
                }, label: {
                    Text("D")
                        .font(.system(size: 20, design: .rounded))
                        .foregroundColor(.purple)
                        .frame(width: 300, alignment: .leading)
                        .padding()
                        .background(Color.white)
                        .fontWeight(.bold)
                        .cornerRadius(10)
                })
            }
        }.task {
            print("Category: \(selectedCategoryName)" )
            print("Category: \(selectedCategoryNumber)" )
            print("Difficukty: \(selectedDifficultyInPopup)" )
            print("https://opentdb.com/api.php?amount=10&category=\(selectedCategoryNumber)&difficulty=\(selectedDifficultyInPopup)&type=multiple&encode=url3986")
            do {
                try await api.getQnAData(selectedCategoryNumber: selectedCategoryNumber, selectedDifficultyInPopup: selectedDifficultyInPopup)
            } catch APIErrors.invalidData {
                print("Invalid Data")
            } catch APIErrors.invalidURL {
                print("Invalid Url")
            } catch APIErrors.invalidResponse {
                print("Invalid Response")
            } catch {
                print("General error")
            }
        }
       // Text("Vald svårighetsgrad: \(isDifficult)")
       // Text("Vald kategori: \(myCategory)")
        
        
    }
}
struct QuizGameScreen_Previews: PreviewProvider {
    static var previews: some View {
        QuizGameScreen(selectedCategoryNumber: .constant(21), selectedCategoryName: .constant("Sport"), selectedDifficultyInPopup: .constant("Easy"))
    }
}

enum APIErrors: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}
