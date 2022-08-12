import UIKit

class ViewController: UIViewController {
    
    //загаданное число
    var number: Int = 0
    
    //раунд
    var round: Int = 1
    
    //сумма очков за раунд
    var points: Int = 0
    
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
        button.addTarget(self, action: #selector(startGame), for: .touchUpInside)
        return button
    }()
    
    var numberLabel: UILabel = {
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

    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        
        //генерация случайного числа
        self.number = Int.random(in: 1...100)
        
        //
        self.numberLabel.text = String(self.number)
        
        view.backgroundColor = greenColor
        startButton.backgroundColor = redColor
        slider.tintColor = redColor
        slider.thumbTintColor = redColor
        slider.maximumTrackTintColor = offRedColor

        
        numberLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        numberLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        numberLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        numberLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        slider.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        slider.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        slider.heightAnchor.constraint(equalToConstant: 30).isActive = true

        startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        startButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 100).isActive = true
        startButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        startButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }
    
    @objc func startGame() {
        let numSlider = Int(self.slider.value)
        if numSlider > self.number {
            self.points += 100 - numSlider + self.number
        } else if numSlider < self.number {
            self.points += 100 - self.number + numSlider
        } else {
            self.points += 100
        }
        
        if self.round == 5 {
            let alert = UIAlertController(
                title: "Game over",
                message: "You earned \(self.points) points",
                preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Start again", style: .default))
            self.present(alert, animated: true, completion: nil)
            self.round = 1
            self.points = 0
        } else {
            self.round += 1
        }
    }
    
    override func loadView() {
        super.loadView()
        
        view.addSubview(numberLabel)
        view.addSubview(startButton)
        view.addSubview(slider)
        
        print("loadView")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisappear")
    }

}

