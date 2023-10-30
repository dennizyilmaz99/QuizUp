//
//  TriviaAPIData.swift
//  QuizUp
//
//  Created by Aran Ali on 2023-10-29.
//

import Foundation

struct QuestionResponse: Codable {
    let results: [Question]
}


// Ändra till decodable
struct Question: Codable {
    var category: String
    var question: String
    var correctAnswer: String
    var incorrectAnswers: [String]
}


