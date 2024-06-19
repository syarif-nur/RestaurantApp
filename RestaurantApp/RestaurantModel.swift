import Foundation

// MARK: - RestaurantResult
struct RestaurantResult: Codable {
    let error: Bool
    let message: String
    let count: Int
    let restaurants: [Restaurant]
}

// MARK: - Restaurant
struct Restaurant: Codable, Identifiable {
    let id, name, description, pictureID: String
    let city: String
    let rating: Double
    
    enum CodingKeys: String, CodingKey {
        case id, name, description
        case pictureID = "pictureId"
        case city, rating
    }
    
    var roundedRating: String {
        String(format: "%.1f", rating)
    }
    
    var imageUrl: URL? {
        URL(string: "https://restaurant-api.dicoding.dev/images/medium/\(pictureID)")
    }
}
