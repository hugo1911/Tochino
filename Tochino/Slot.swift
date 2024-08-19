import SwiftUI

struct Slot: View {
    
    private var symbols = ["Apple", "Star", "Cherry"]
    
    @State private var numbers = [1, 2, 0]
    
    @State private var credits = 1000
    
    private var betAmount = 5
    
    var body: some View {
        ZStack {
            // Diseño principal
            Rectangle()
                .foregroundColor(Color(red: 200/255, green: 143/255, blue: 32/255))
                .ignoresSafeArea()
            
            Rectangle()
                .foregroundColor(Color(red: 228/255, green: 195/255, blue: 76/255))
                .rotationEffect(Angle(degrees: 45))
                .ignoresSafeArea()
            
            VStack {
                
                Spacer()
                
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    
                    Text("TOCHINO")
                        .bold()
                        .foregroundColor(.white)
                    
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                }
                .scaleEffect(2)
                
                Spacer()
                
                // Creditochos counter
                Text("Tochips: \(credits)")
                    .foregroundColor(.black)
                    .padding(.all, 10)
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(20)
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Image(symbols[numbers[0]]).resizable()
                        .aspectRatio(contentMode: .fit)
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(20)
                    
                    Image(symbols[numbers[1]]).resizable()
                        .aspectRatio(contentMode: .fit)
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(20)
                    
                    Image(symbols[numbers[2]]).resizable()
                        .aspectRatio(contentMode: .fit)
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(20)
                    
                    Spacer()
                }
                
                Spacer()
                
                // Botón
                Button(action: {
                    self.numbers[0] = Int.random(in: 0..<self.symbols.count)
                    self.numbers[1] = Int.random(in: 0..<self.symbols.count)
                    self.numbers[2] = Int.random(in: 0..<self.symbols.count)
                    
                    // Checar las ganancias
                    if self.numbers[0] == self.numbers[1] && self.numbers[1] == self.numbers[2] {
                        // Ganas
                        self.credits += self.betAmount * 10
                    } else {
                        self.credits -= self.betAmount
                    }
                }) {
                    Text("Spin")
                        .bold()
                        .foregroundColor(.white)
                        .padding(.all, 10)
                        .padding([.leading, .trailing], 30)
                        .background(Color.pink)
                        .cornerRadius(20)
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    Slot()
}
