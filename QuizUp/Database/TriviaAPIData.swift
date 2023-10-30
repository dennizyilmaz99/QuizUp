//
//  TriviaAPIData.swift
//  QuizUp
//
//  Created by Aran Ali on 2023-10-29.
//

import Foundation

struct Question: Codable {
    let category: String
    let question: String
    let correctAnswer: String
    let incorrectAnswers: [String]
}


struct QuestionResponse: Codable {
    let results: [Question]
}
