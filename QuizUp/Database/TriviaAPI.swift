//
//  TriviaAPI.swift
//  QuizUp
//
//  Created by Aran Ali on 2023-10-25.
//

import Foundation
import SwiftUI

class TriviaAPI {
    
    static func fetchQuestions(category: Int, difficulty: String, completion: @escaping ([Question]?) -> Void) {
        let endpoint =  "https://opentdb.com/api.php?amount=10&category=\(category)&difficulty=\(difficulty)&type=multiple&encode=url3986"
        
   
       
        
        if let url = URL(string: endpoint) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let questions = try decoder.decode(QuestionResponse.self, from: data)
                        completion(questions.results)
                    } catch {
                        print("Error decoding JSON: \(error)")
                        completion(nil)
                    }
                } else {
                    print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                    completion(nil)
                }
            }.resume()
        } else {
            print("Invalid URL")
            completion(nil)
        }
        
    }
    
}

enum APIErrors: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}


