import Foundation

struct QuestionResponse: Decodable {
    let results: [Question]
}

struct Question: Decodable {
    var category: String
    var question: String
    var correctAnswer: String
    var incorrectAnswers: [String]
}


