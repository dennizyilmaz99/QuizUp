import Foundation
import SwiftUI

// To store information of all the categories
struct CategoriesData: Identifiable {
        var id: UUID = UUID() // Each category have an unique ID
        var categorieName: String
}
