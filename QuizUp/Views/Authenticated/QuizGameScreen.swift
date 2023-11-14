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
    @State var showMenu = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.homeScreenGradientLight, Color.homeScreenGradientDark]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Spacer()
                    Image("Icon5").resizable().aspectRatio(contentMode:.fit).frame(width: 175, height: 175).padding(.leading, 38)
                    Spacer()
                    Button(action: {
                            withAnimation(Animation.easeOut(duration: 0.2)) {
                                showMenu.toggle()
                            }
                    }) {
                        Image("menuicon2").resizable().aspectRatio(contentMode:.fit).frame(width: 22, height: 22).padding(.trailing, 10).foregroundStyle(.white)
                    }
                }.offset(y: -19)
                Spacer()
            }.edgesIgnoringSafeArea(.all)
            VStack {
                
            }
            Text(currentQuestionText)
                .font(.system(size: 23, design:
                        .rounded)).fontWeight(.bold)
                .foregroundColor(.white)
                .offset(x: 100, y: -245)
            VStack{
                if !api.QnAData.isEmpty {
                    if let renderQuestion = api.QnAData[currentQuestionIndex].question.removingPercentEncoding {
                        VStack {
                            Text(renderQuestion)
                                .font(.system(size: 17, design: .rounded))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .offset(y: -30)
                        }.frame(maxWidth: 300)
                        
                    } else {
                        Text("Failed to decode question")
                            .font(.system(size: 23, design: .rounded))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .offset(y: -100)
                    }
                } else {
                    VStack {
                        Text("Loading...")
                            .font(.system(size: 23, design: .rounded))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .offset(y: -100)
                    }
                }
                VStack (spacing: 20) {
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
                                .font(.system(size: 17, design: .rounded))
                                .foregroundColor(answerSelected == shuffledAnswer ? .white : .purple)
                                .frame(width: 225, height: 30, alignment: .leading)
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
                }.frame(maxWidth: .infinity, maxHeight: 200).padding(20)
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
                        .padding(20)
                        .background(Color.white)
                        .fontWeight(.bold)
                        .cornerRadius(10)
                        .offset(y: 50)
                })
                .disabled(!hasUserAnswered)
                .onAppear {
                    self.cachedShuffledAnswers = shuffleAnswers()
                }
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .alert(isPresented: $isGameCompleted) {
                Alert(
                    title: Text("Avslutat spel"),
                    message: Text("Din poäng är \(score) utav 10"),
                    primaryButton: .default(Text("Spela igen")) {
                        restartGame()
                        if let userID = db.auth.currentUser?.uid {
                            db.updateScoreInFirestore(categoryName: self.selectedCategoryName, score: self.score, userId: userID)
                        }
                    },
                    secondaryButton: .default(Text("Avsluta")) {
                        withAnimation(.easeOut){
                            navigatingToHomeScreen = true
                        }
                        if let userID = db.auth.currentUser?.uid {
                            db.updateScoreInFirestore(categoryName: self.selectedCategoryName, score: self.score, userId: userID)
                        }
                    }
                )
            }
            if navigatingToHomeScreen {
                withAnimation(.easeOut){
                    HomeScreen()
                }
            }
            if showMenu {
                MenuPopUpView(showMenu: $showMenu, navigatingToHomeScreen: $navigatingToHomeScreen)
            }
        }.navigationBarBackButtonHidden().task {
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


