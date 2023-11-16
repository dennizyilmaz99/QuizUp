import Foundation
import SwiftUI

class TriviaAPI: ObservableObject {
    
    struct TriviaAnswer {
        let text: String
        let isCorrect: Bool
    }
   
    @Published var QnAData: [Question] = [] // Denna variabel kommer användas för att lagra de hämtade trivia-frågorna
    
    // Denna funkiton ansvarar för att hämta trivia frågorna
    func getQnAData(selectedCategoryNumber: Int, selectedDifficultyInPopup: String) async throws {
        
        let endpoint = "https://opentdb.com/api.php?amount=10&category=\(selectedCategoryNumber)&difficulty=\(selectedDifficultyInPopup)&type=multiple&encode=url3986"
        
        // Om vi inte lyckas skapa en URL med vald kateogri och svårighetsgrad kastar vi ett felmeddelande
        guard let url = URL(string: endpoint) else { throw APIErrors.invalidURL }
        
        // skapar en URL request för den angivna URL:en
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // ett asynkront anrop till API:et
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // Kollar om responsen vi fick är framgångsrikt, om inte kastar vi ett felmeddelande
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            print("Ogiltig respons från servern.")
            throw APIErrors.invalidResponse
        }
        
        do {
            // avkoda data från JSON/API-anropet till struct QuestionResponse
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let questionResponse = try decoder.decode(QuestionResponse.self, from: data)
            
            // uppdatera QnAData med de avkodade trivia frågorna, om det inte lyckades kasta ett felmeddelande
            DispatchQueue.main.sync {
                print("Fetching data...")
                self.QnAData = questionResponse.results
                print("Fetched data: \(QnAData)")
            }
        } catch {
            print("Fel vid avkodning av data från servern.")
            throw APIErrors.invalidData
        }
        
    }
}
