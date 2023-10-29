import Foundation

struct Question: Codable {
    let category: String
    let question: String
    let correctAnswer: String
    let incorrectAnswers: [String]
}
