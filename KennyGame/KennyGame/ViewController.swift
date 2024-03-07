import UIKit

class ViewController: UIViewController {

    var score = 0
    var timer = Timer()
    var counter = 0
    var kennyArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    @IBOutlet weak var keny1: UIImageView!
    @IBOutlet weak var keny2: UIImageView!
    @IBOutlet weak var keny3: UIImageView!
    @IBOutlet weak var rigby4: UIImageView!
    @IBOutlet weak var rigby5: UIImageView!
    @IBOutlet weak var rigby7: UIImageView!
    @IBOutlet weak var rigby6: UIImageView!
    @IBOutlet weak var rigby8: UIImageView!
    @IBOutlet weak var rigby9: UIImageView!
    
    override func viewDidLoad() {
           super.viewDidLoad()
           
           scoreLabel.text = "Skor: \(score)"
           
           //Highscore check
           
           let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
           
           if storedHighScore == nil {
               highScore = 0
               highScoreLabel.text = "Yüksek Skor: \(highScore)"
           }
           
           if let newScore = storedHighScore as? Int {
               highScore = newScore
               highScoreLabel.text = "Yüksek Skor: \(highScore)"
           }
           
           
           //Images
           keny1.isUserInteractionEnabled = true
           keny2.isUserInteractionEnabled = true
           keny3.isUserInteractionEnabled = true
        rigby4.isUserInteractionEnabled = true
        rigby5.isUserInteractionEnabled = true
        rigby6.isUserInteractionEnabled = true
        rigby7.isUserInteractionEnabled = true
        rigby8.isUserInteractionEnabled = true
        rigby9.isUserInteractionEnabled = true
           
           let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
           let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
           let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
           let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
           let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
           let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
           let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
           let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
           let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
           
           keny1.addGestureRecognizer(recognizer1)
           keny2.addGestureRecognizer(recognizer2)
           keny3.addGestureRecognizer(recognizer3)
           rigby4.addGestureRecognizer(recognizer4)
        rigby5.addGestureRecognizer(recognizer5)
        rigby6.addGestureRecognizer(recognizer6)
        rigby7.addGestureRecognizer(recognizer7)
        rigby8.addGestureRecognizer(recognizer8)
        rigby9.addGestureRecognizer(recognizer9)
           
           kennyArray = [keny1, keny2, keny3,  rigby4,  rigby5, rigby6,  rigby7,  rigby8,  rigby9]
           
           //Timers
           counter = 10
           timeLabel.text = String(counter)
           
           timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
           hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
           
           hideKenny()

           
       }
       
       
       @objc func hideKenny() {
           
           for kenny in kennyArray {
               kenny.isHidden = true
           }
           
           let random = Int(arc4random_uniform(UInt32(kennyArray.count - 1)))
           kennyArray[random].isHidden = false
           
       }
       
       
       
       @objc func increaseScore() {
           score += 1
           scoreLabel.text = "Skor: \(score)"
       }
       
       @objc func countDown() {
           
           counter -= 1
           timeLabel.text = String(counter)
           
           if counter == 0 {
               timer.invalidate()
               hideTimer.invalidate()
               
               for kenny in kennyArray {
                   kenny.isHidden = true
               }
               
               //HighScore
               
               if self.score > self.highScore {
                   self.highScore = self.score
                   highScoreLabel.text = "Yüksek Skor: \(self.highScore)"
                   UserDefaults.standard.set(self.highScore, forKey: "highscore")
               }
               
               
               //Alert
               
               let alert = UIAlertController(title: "Süre Doldu", message: "Tekrar oynamak istermisin ?", preferredStyle: UIAlertController.Style.alert)
               let okButton = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.cancel, handler: nil)
               
               let replayButton = UIAlertAction(title: "Tekrar", style: UIAlertAction.Style.default) { (UIAlertAction) in
                   //replay function
                   
                   self.score = 0
                   self.scoreLabel.text = "Skor: \(self.score)"
                   self.counter = 10
                   self.timeLabel.text = String(self.counter)
                   
                   
                   self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                   self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideKenny), userInfo: nil, repeats: true)
               }
               
               alert.addAction(okButton)
               alert.addAction(replayButton)
               self.present(alert, animated: true, completion: nil)
               
               
               
           }
           
       }
}

