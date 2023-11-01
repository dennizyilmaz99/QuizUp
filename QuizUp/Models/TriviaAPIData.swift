import Foundation

struct QuestionResponse: Decodable {
    var results: [Question]
}

struct Answer: Identifiable {
    var id = UUID()
    var text: String
    var isCorrect: Bool
}
        
struct Question: Decodable {
    var category: String
    var question: String
    var correctAnswer: String
    var incorrectAnswers: [String]
}




    
    



