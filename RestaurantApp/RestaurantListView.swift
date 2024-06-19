//
//  RestaurantListView.swift
//  RestaurantApp
//
//  Created by Syarif on 16/05/24.
//

import SwiftUI

struct RestaurantListView: View{
    @StateObject private var viewModel = RestaurantViewModel()
    
    var body: some View{
        NavigationView {
            VStack {
                if let restaurantResult = viewModel.body {
                    List(restaurantResult.restaurants) { restaurant in
                        NavigationLink(destination: RestaurantDetailView(restaurant: restaurant)) {
                            HStack(alignment: .top) {
                                if let imageUrl = restaurant.imageUrl {
                                    AsyncImage(url: imageUrl) { phase in
                                        switch phase {
                                        case .empty:
                                            ProgressView()
                                                .frame(width: 100, height: 100)
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 100, height: 100)
                                                .clipped()
                                        case .failure:
                                            Image(systemName: "photo")
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 100, height: 100)
                                                .clipped()
                                        @unknown default:
                                            EmptyView()
                                        }
                                    }
                                } else {
                                    Image(systemName: "photo")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 100, height: 100)
                                        .clipped()
                                }
                                
                                VStack(alignment: .leading) {
                                    Text(restaurant.name)
                                        .font(.headline)
                                    Text(restaurant.city)
                                        .font(.subheadline)
                                    Text("Rating: \(restaurant.roundedRating)")
                                        .font(.caption)
                                }
                                .padding(.leading, 8)
                            }
                        }
                    }
                } else {
                    Text("Loading...")
                        .onAppear {
                            viewModel.fetchRemoteData()
                        }
                }
            }
            .navigationTitle("Restaurants")
        }
    }
}
