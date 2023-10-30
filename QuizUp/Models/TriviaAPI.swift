//
//  TriviaAPI.swift
//  QuizUp
//
//  Created by Aran Ali on 2023-10-25.
//

import Foundation
import SwiftUI

class TriviaAPI: ObservableObject {
   
   @Published var QnAData: [Question] = []
    
    func getQnAData(selectedCategoryNumber: Int, selectedDifficultyInPopup: String) async throws {
        
        let endpoint = "https://opentdb.com/api.php?amount=10&category=\(selectedCategoryNumber)&difficulty=\(selectedDifficultyInPopup)&type=multiple&encode=url3986"
        
        guard let url = URL(string: endpoint) else {throw APIErrors.invalidURL}
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw APIErrors.invalidResponse
        }
        
        do {
    
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let questionResponse = try decoder.decode(QuestionResponse.self, from: data)
            
            DispatchQueue.main.sync {
                self.QnAData = questionResponse.results
            }
        } catch {
            throw APIErrors.invalidData
        }
        
    }
    
    
    
}

/*
 API ger inte rätt svar eftersom
 Kolla vad den förväntar sig, kanske liten bokstav, annat ord istället för de vi lagt in som variabler 
 */
