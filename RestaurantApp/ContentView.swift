import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            RestaurantListView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("List")
                }
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
    }
}
