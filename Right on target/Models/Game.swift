import Foundation

class Game: GameProtocol {
    var score: Int = 0
    
    // Minimal secret value
    private var minSecretValue: Int
    
    // Maximal secret value
    private var maxSecretValue: Int
    
    var currentSecretValue: Int = 0
    
    // Number of rounds
    private var lastRound: Int
    private var currentRound: Int = 1
    
    var isGameEnded: Bool {
        if currentRound >= lastRound {
            return true
        } else {
            return false
        }
    }
    
    init?(startValue: Int, endValue: Int, rounds: Int) {
        //Start value for choosing a random number cannot be greater than the end value
        guard startValue <= endValue else {
            return nil
        }
        minSecretValue = startValue
        maxSecretValue = endValue
        lastRound = rounds
        currentSecretValue = self.getNewSecretValue()
    }
    
    func restartGame() {
        currentRound = 0
        score = 0
        startNewRound()
    }
    
    func startNewRound() {
        currentSecretValue = self.getNewSecretValue()
        currentRound += 1
    }
    
    // Guess and return a new random value
    private func getNewSecretValue() -> Int {
        (minSecretValue...maxSecretValue).randomElement()!
    }
    
    // Calculates the number of points
    func calculateScore(with value: Int) {
        if value > currentSecretValue {
            score += 50 - value + currentSecretValue
        } else if value < currentSecretValue {
            score += 50 - currentSecretValue + value
        } else {
            score += 50
        }
    }
    
}

protocol GameProtocol {
    
    //Points earned
    var score: Int { get }
    
    //Secret value
    var currentSecretValue: Int { get }
    
    //Check if the game is ended
    var isGameEnded: Bool { get }
    
    //Start new game
    func restartGame()
    
    //Begin new round with new value
    func startNewRound()
    
    //Compares the passed value with the given one and calculates the points
    func calculateScore(with value: Int)
    
}
