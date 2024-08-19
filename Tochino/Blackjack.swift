import SwiftUI

struct Card: Identifiable {
    let id = UUID()
    let rank: String
    let suit: String
    var value: Int {
        switch rank {
        case "A": return 11
        case "K", "Q", "J": return 10
        default: return Int(rank) ?? 0
        }
    }
}

class BlackjackGame: ObservableObject {
    @Published var playerHand: [Card] = []
    @Published var dealerHand: [Card] = []
    @Published var deck: [Card] = []
    @Published var gameStatus: String = ""
    
    init() {
        resetGame()
    }
    
    func resetGame() {
        playerHand = []
        dealerHand = []
        gameStatus = ""
        createDeck()
        dealInitialCards()
    }
    
    func createDeck() {
        let suits = ["♠️", "♥️", "♦️", "♣️"]
        let ranks = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]
        deck = []
        
        for suit in suits {
            for rank in ranks {
                deck.append(Card(rank: rank, suit: suit))
            }
        }
        
        deck.shuffle()
    }
    
    func dealInitialCards() {
        playerHand.append(deck.removeFirst())
        dealerHand.append(deck.removeFirst())
        playerHand.append(deck.removeFirst())
        dealerHand.append(deck.removeFirst())
    }
    
    func hit() {
        playerHand.append(deck.removeFirst())
        if calculateHandValue(playerHand) > 21 {
            gameStatus = "¡Te has pasado! La casa gana."
        }
    }
    
    func stand() {
        while calculateHandValue(dealerHand) < 17 {
            dealerHand.append(deck.removeFirst())
        }
        
        let playerValue = calculateHandValue(playerHand)
        let dealerValue = calculateHandValue(dealerHand)
        
        if dealerValue > 21 {
            gameStatus = "¡La casa se ha pasado! Tú ganas."
        } else if playerValue > dealerValue {
            gameStatus = "¡Tú ganas!"
        } else if playerValue < dealerValue {
            gameStatus = "La casa gana."
        } else {
            gameStatus = "Empate."
        }
    }
    
    func calculateHandValue(_ hand: [Card]) -> Int {
        var value = 0
        var aceCount = 0
        
        for card in hand {
            if card.rank == "A" {
                aceCount += 1
            }
            value += card.value
        }
        
        while value > 21 && aceCount > 0 {
            value -= 10
            aceCount -= 1
        }
        
        return value
    }
}

struct BlackjackView: View {
    @StateObject private var game = BlackjackGame()
    
    var body: some View {
        VStack {
            Text("Blackjack")
                .font(.largeTitle)
                .padding()
            
            HStack {
                VStack {
                    Text("Jugador")
                    ForEach(game.playerHand) { card in
                        Text("\(card.rank)\(card.suit)")
                    }
                    Text("Valor: \(game.calculateHandValue(game.playerHand))")
                }
                
                Spacer()
                
                VStack {
                    Text("Casa")
                    ForEach(game.dealerHand) { card in
                        Text("\(card.rank)\(card.suit)")
                    }
                    Text("Valor: \(game.calculateHandValue(game.dealerHand))")
                }
            }
            .padding()
            
            Text(game.gameStatus)
                .font(.headline)
                .padding()
            
            HStack {
                Button("Pedir") {
                    game.hit()
                }
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                Button("Plantarse") {
                    game.stand()
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            
            Button("Nueva partida") {
                game.resetGame()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
    }
}
