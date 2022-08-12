import UIKit

class ViewController: UIViewController {
    
    var game: Game!
    
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        
        view.addSubview(secretNumberLabel)
        view.addSubview(startButton)
        view.addSubview(slider)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create Game entity
        game = Game(startValue: 1, endValue: 50, rounds: 5)
        
        // Update data about current value of secret number
        updateLabelWithSecretNumber(newText: String(game.currentSecretValue))
        
        view.backgroundColor = greenColor
        startButton.backgroundColor = redColor
        slider.tintColor = redColor
        slider.thumbTintColor = redColor
        slider.maximumTrackTintColor = offRedColor
        
        
        secretNumberLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        secretNumberLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        secretNumberLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        secretNumberLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        slider.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        slider.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        slider.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        startButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 100).isActive = true
        startButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        startButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }
    
    // MARK: - Interaction between View and Model
    
    // Check chosen number
    @objc func checkNumber() {
        
        // Subtract points for the round
        game.calculateScore(with: Int(slider.value))
        // Check the game is not ended
        if game.isGameEnded {
            showAlertWith(score: game.score)
            //Begin the game again
            game.restartGame()
        } else {
            game.startNewRound()
        }
        // Update data about current value of secret number
        updateLabelWithSecretNumber(newText: String(game.currentSecretValue))
        
    }
    
    // MARK: - View update
    // Update the text of the secret value
    private func updateLabelWithSecretNumber(newText: String) {
        secretNumberLabel.text = newText
    }
    
    private func showAlertWith(score: Int) {
        let alert = UIAlertController(
            title: "Game over",
            message: "You've earned \(score) points",
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Restart", style: .default))
        self.present(alert, animated: true)
    }
    
    //sRGB colors
    let redColor: UIColor = UIColor(red: 255/255.0, green: 111/255.0, blue: 125/255.0, alpha: 1.0)
    let greenColor: UIColor = UIColor(red: 106/255.0, green: 158/255.0, blue: 112/255.0, alpha: 1.0)
    let offRedColor: UIColor = UIColor(red: 181/255.0, green: 116/255.0, blue: 102/255.0, alpha: 1.0)
    
    var startButton: UIButton = {
        let button = UIButton()
        button.setTitle("START", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(checkNumber), for: .touchUpInside)
        return button
    }()
    
    var secretNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var slider: UISlider = {
        let slider = UISlider()
        slider.maximumValue = 100
        slider.minimumValue = 1
        slider.value = 50
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
}


