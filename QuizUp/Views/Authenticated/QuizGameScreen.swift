import Foundation
import SwiftUI

struct CategoryScore {
    var scores: [String: Int] = [
        "Sport": 0,
        "Geografi": 0,
        "Historia": 0,
        "Teknik": 0
    ]
}

struct QuizGameScreen: View {
    
    @StateObject var api = TriviaAPI()
    @EnvironmentObject var db: DatabaseConfig
    @Binding var selectedCategoryNumber: Int
    @Binding var selectedCategoryName: String
    @Binding var selectedDifficultyInPopup: String
    @State var currentQuestionIndex = 0
    @State var score = 0
    @State var answerSelected: String?
    @State var currentQuestionText = "1 out of 10"
    @State var isGameCompleted = false
    @State var hasUserAnswered = false
    @State var navigatingToHomeScreen = false
    @State var cachedShuffledAnswers = [String]()

    var body: some View {
        
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color.homeScreenGradientLight, Color.homeScreenGradientDark]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Image("Icon5").resizable().aspectRatio(contentMode:.fit).frame(width: 175, height: 175)
                Spacer()
            }.edgesIgnoringSafeArea(.all)
            
            Text(currentQuestionText)
                .font(.system(size: 23, design:
                        .rounded)).fontWeight(.bold)
                .foregroundColor(.white)
                .offset(x: 100, y: -300)
            
            VStack{
                if !api.QnAData.isEmpty {
                    if let renderQuestion = api.QnAData[currentQuestionIndex].question.removingPercentEncoding {
                        
                        Text(renderQuestion)
                            .font(.system(size: 23, design: .rounded))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                        
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
                VStack {
                ForEach(cachedShuffledAnswers, id: \.self) { shuffledAnswer in
                    Button( action: {
                        if answerSelected == nil {
                            if let decodedAnswer = shuffledAnswer.removingPercentEncoding {
                                answerSelected = decodedAnswer.removingPercentEncoding
                                hasUserAnswered = true }
                            if shuffledAnswer.removingPercentEncoding == api.QnAData[currentQuestionIndex].correctAnswer.removingPercentEncoding {
                                
                                answerSelected = shuffledAnswer.removingPercentEncoding
                                
                                
                                if let userAnswer = answerSelected?.removingPercentEncoding {
                                    if userAnswer == api.QnAData[currentQuestionIndex].correctAnswer.removingPercentEncoding {
                                        score += 1
                                        print("Correct answer, your score: \(score)")
                                    } else {
                                        print("Wrong answer, your score: \(score)")
                                    }
                                }
                            } else {
                                print("wrong answer, player score: \(score)")
                            }
                        }
                    })
                    {
                        Text(shuffledAnswer)
                            .font(.system(size: 20, design: .rounded))
                            .foregroundColor(answerSelected == shuffledAnswer ? .white : .purple)
                            .frame(width: 300, alignment: .leading)
                            .padding()
                            .background(
                                answerSelected == shuffledAnswer.removingPercentEncoding ?
                                (shuffledAnswer == api.QnAData[currentQuestionIndex].correctAnswer.removingPercentEncoding ? Color.green : Color.red) :
                                    Color.white
                            )
                            .fontWeight(.bold)
                            .cornerRadius(10)
                        
                    }
                    .disabled(hasUserAnswered)
                    .disabled(isGameCompleted)
                }
                }.padding(20)
                Button(action: {
                    if hasUserAnswered {
                        answerSelected = nil
                        goToNextQuestion()
                        hasUserAnswered = false
                        
                    }
                }, label: {
                        Text(isGameCompleted ? "Klar" : "Nästa")
                            .font(.system(size: 20, design: .rounded))
                            .foregroundColor(.purple)
                            .padding(40)
                            .background(Color.white)
                            .fontWeight(.bold)
                            .cornerRadius(10)
                })
                .disabled(!hasUserAnswered)
                .onAppear {
                    self.cachedShuffledAnswers = shuffleAnswers()
                }
            }.onAppear {
                print(api.QnAData)
            }
            
            .alert(isPresented: $isGameCompleted) {
                Alert(
                    title: Text("Game over"),
                    message: Text("Your score was \(score) out of 10"),
                    primaryButton: .default(Text("Spela igen")) {
                        restartGame()
                        if let userID = db.auth.currentUser?.uid {
                            db.updateScoreInFirestore(categoryName: self.selectedCategoryName, score: self.score, userId: userID)
                        }
                    },
                    secondaryButton: .default(Text("Avsluta")) {
                        withAnimation(.easeOut){
                            goToHomeScreen()
                        }
                        if let userID = db.auth.currentUser?.uid {
                            db.updateScoreInFirestore(categoryName: self.selectedCategoryName, score: self.score, userId: userID)
                        }
                    }
                )
            }
            if navigatingToHomeScreen {
                HomeScreen()
            }
        }.task {
                
                do {
                    try await api.getQnAData(selectedCategoryNumber: selectedCategoryNumber, selectedDifficultyInPopup: selectedDifficultyInPopup)
                    cachedShuffledAnswers = shuffleAnswers()
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
    
    func goToHomeScreen() {
        navigatingToHomeScreen = true
    }
    
    func restartGame() {
        score = 0
        currentQuestionIndex = 0
        answerSelected = nil
        isGameCompleted = false
        hasUserAnswered = false
        currentQuestionText = "1 out of 10"
        api.QnAData = []
        cachedShuffledAnswers = shuffleAnswers()
        getNewQuestions()
    }
    func getNewQuestions() {
        Task {
            do {
                try await api.getQnAData(selectedCategoryNumber: selectedCategoryNumber, selectedDifficultyInPopup: selectedDifficultyInPopup)
                
                // Uppdatera svarsalternativen med de nya frågorna
                cachedShuffledAnswers = shuffleAnswers()
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
    func shuffleAnswers() -> [String] {
        
        if currentQuestionIndex < api.QnAData.count {
            var answers = api.QnAData[currentQuestionIndex].incorrectAnswers
            answers.append(api.QnAData[currentQuestionIndex].correctAnswer)
            answers = answers.compactMap { $0.removingPercentEncoding }
            return answers.shuffled()
        } else {
            return []  // Returnera en tom array om index är ogiltigt
        }
    }
    func goToNextQuestion () {
        if currentQuestionIndex < api.QnAData.count - 1 {
            currentQuestionIndex += 1
            
            let questionNumber = currentQuestionIndex + 1
            currentQuestionText = "\(questionNumber) out of 10"
            cachedShuffledAnswers = shuffleAnswers()
            
        } else if currentQuestionIndex == api.QnAData.count - 1 && !isGameCompleted {
            isGameCompleted = true
            
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
