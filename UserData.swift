import Foundation
import FirebaseFirestoreSwift

struct UserData: Codable, Identifiable {
    
    @DocumentID var id: String?
    var name: String?
    var email: String?
    var password: String?
}
