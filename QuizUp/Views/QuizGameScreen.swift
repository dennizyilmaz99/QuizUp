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
    
    
    var isDifficult: String // Hämtar värdet av svårighetsgraden användaren har valt i PopUpView
    var myCategory: String // Hämtar värdet av kateogrin som användaren valt i GameScreen
    
    @State private var questions: [Question] = []

    
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
            Text("Here is a question")
                .font(.system(size: 23, design:
                        .rounded)).fontWeight(.bold)
                .foregroundColor(.white)
                .offset(y: -200)
            
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
        }
       // Text("Vald svårighetsgrad: \(isDifficult)")
       // Text("Vald kategori: \(myCategory)")
        
        
    }
}
struct QuizGameScreen_Previews: PreviewProvider {
    static var previews: some View {
        QuizGameScreen(isDifficult: "", myCategory: "")
    }
}
