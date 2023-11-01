
import Foundation
import SwiftUI


struct QuizGameScreen: View {
    
    @StateObject var api = TriviaAPI()
    @Binding var selectedCategoryNumber: Int
    @Binding var selectedCategoryName: String
    @State var currentQuestionIndex = 0
    @Binding var selectedDifficultyInPopup: String
    @State var score = 0
    @State var answerSelected: String?
    
    
    func shuffleAnswers() -> [String] {
        var answers = api.QnAData[currentQuestionIndex].incorrectAnswers
        answers.append(api.QnAData[currentQuestionIndex].correctAnswer)
        return answers.shuffled()
    }
    
    func goToNextQuestion () {
        if currentQuestionIndex < api.QnAData.count - 1 {
            currentQuestionIndex += 1
        }
    }
    
   
    
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
            
            VStack{
                
        if !api.QnAData.isEmpty {
            if currentQuestionIndex < api.QnAData.count {
                if let renderQuestion = api.QnAData[currentQuestionIndex].question.removingPercentEncoding {
                    
                    Text(renderQuestion)
                        .font(.system(size: 23, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .offset(y: -100)
                } else {
                    
                    Text("Failed to decode question")
                        .font(.system(size: 23, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .offset(y: -100)
                }
            } else {
                
                Text("Loading...")
                    .font(.system(size: 23, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .offset(y: -100)
            }
        }
                
        if !api.QnAData.isEmpty {
            if currentQuestionIndex < api.QnAData.count { // Check if the current question index is within bounds
                ForEach(shuffleAnswers(), id: \.self) { shuffledAnswer in
                    Button(action: {
                        if answerSelected == nil {
                            answerSelected = shuffledAnswer
                        }
                        if shuffledAnswer == api.QnAData[currentQuestionIndex].correctAnswer {
    
                            answerSelected = shuffledAnswer
                            
                            if let userAnswer = answerSelected {
                                if userAnswer == api.QnAData[currentQuestionIndex].correctAnswer {
                                    score += 1
                                    print("Correct answer, your score: \(score)")
                                } else {
                                    print("Wrong answer, your score: \(score)")
                                }
                            }
                            
                    } else {
                        
                            print("wrong answer, player score: \(score)")
                      
                        }
                    }) {
                        
                        Text(shuffledAnswer)
                            .font(.system(size: 20, design: .rounded))
                            .foregroundColor(.purple)
                            .frame(width: 300, alignment: .leading)
                            .padding()
                            .background(
                                answerSelected == shuffledAnswer ?
                                (shuffledAnswer == api.QnAData[currentQuestionIndex].correctAnswer ? Color.green : Color.red) :
                                Color.white
                            )
                            .fontWeight(.bold)
                            .cornerRadius(10)
                                
                                
                    }
                }
            }
        }
                
                Button(action: {
                    answerSelected = nil
                    goToNextQuestion()
                }, label: {
                    Text("Next")
                        .font(.system(size: 20, design: .rounded))
                        .foregroundColor(.purple)
                        .padding(40)
                        .background(Color.white)
                        .fontWeight(.bold)
                        .cornerRadius(10)
                })
    }
                       
        } .task {
                
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

