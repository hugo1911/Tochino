import SwiftUI

struct HomeView: View {
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                Rectangle()
                    .foregroundStyle(.blue)
                    .background(.orange)
                    .edgesIgnoringSafeArea(.bottom)
                
                VStack {
                    Text("Bienvenido \(authenticationViewModel.user?.email ?? "No User")")
                        .padding(.top, 32)
                    
                    Spacer()
                    
                    Text("Juegos disponibles")
                    
                    Spacer().frame(height:80)
                    
                    NavigationLink("Slots", destination: Slot())
                        .foregroundStyle(.black)
                    
                    NavigationLink("Blackjack", destination: BlackjackView())
                        .foregroundStyle(.black)
                        .padding(.top, 20)
                    
                    Spacer()
                        .padding(.bottom)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Home")
            .toolbar {
                Button("Logout") {
                    authenticationViewModel.logout()
                }
                .foregroundColor(.white)
                .font(.subheadline)
                .padding(8)
                .background(Color.black)
                .cornerRadius(10)
            }
        }
    }
}

#Preview {
    HomeView(authenticationViewModel: AuthenticationViewModel())
}
