import Combine
import Foundation

class RestaurantViewModel: ObservableObject {
    @Published private var restaurantResult: RestaurantResult?
    
    var body: RestaurantResult? {
        return restaurantResult
    }
    
    func fetchRemoteData() {
        let url = URL(string: "https://restaurant-api.dicoding.dev/list")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error while fetching data:", error)
                return
            }
            
            guard let data = data else {
                print("No data received.")
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(RestaurantResult.self, from: data)
                DispatchQueue.main.async {
                    self.restaurantResult = decodedData
                }
            } catch {
                print("Failed to decode JSON:", error)
            }
        }
        
        task.resume()
    }
}
