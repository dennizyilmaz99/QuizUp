//
//  UserData.swift
//  QuizUp
//
//  Created by Aran Ali on 2023-10-18.
//

import Foundation
import FirebaseFirestoreSwift

struct UserData: Codable, Identifiable {
    
    @DocumentID var id: String?
    var name: String?
    var email: String?
    var password: String?
}
