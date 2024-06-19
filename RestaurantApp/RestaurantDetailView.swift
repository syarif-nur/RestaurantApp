import SwiftUI

struct RestaurantDetailView: View {
    let restaurant: Restaurant
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if let imageUrl = restaurant.imageUrl {
                    AsyncImage(url: imageUrl) { phase in
                        switch phase {
                        case .empty:
                            ZStack {
                                Color.clear
                                ProgressView()
                                    .frame(width: 200, height: 200)
                            }
                            .frame(width: 400, height: 200)
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 200)
                                .clipped()
                        case .failure:
                            Image(systemName: "photo")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 200)
                                .clipped()
                        @unknown default:
                            EmptyView()
                        }
                    }
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 200)
                        .clipped()
                }
                
                VStack(alignment: .leading, spacing: 16) {
                    Text(restaurant.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text(restaurant.city)
                        .font(.title2)
                        .foregroundColor(.secondary)
                    Text("Rating: \(restaurant.roundedRating)")
                        .font(.headline)
                    
                    Text(restaurant.description)
                        .font(.body)
                }
                .padding()
            }
        }
        .navigationTitle("Restaurant Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}


