//
//  ViewController.swift
//  Kojima-Name-Generator-App
//
//  Created by Mike Nguyen on 8/20/20.
//  Copyright © 2020 Mike Nguyen. All rights reserved.
//

import UIKit
import AVFoundation

class QuestionViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerField: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var RNGLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var snakeBox: UIImageView!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var leftButtonConstraint: NSLayoutConstraint!
    @IBOutlet weak var rightButtonConstraint: NSLayoutConstraint!
    
    var questionManager = QuestionManager()
    var nameCalculator = NameCalculator()
    var player: AVAudioPlayer?
    
    var manCondition: Bool = false
    var cloneCondition: Bool = false
    var conditionCondition: Bool = false
    
    var input = String()
    var pickerCount = 0
    var pickerValues = [
        ["Select One", "Liquid", "Solid", "Gas"],
        
        ["Select One", "Aries", "Taurus", "Gemini", "Cancer", "Leo", "Virgo", "Libra", "Scorpio",
         "Sagittarius", "Capricorn", "Aquarius", "Pisces"],
        
        ["Select One", "Randy Miller", "Santa Claus", "Ego", "Mr. Nobody", "John Ruth", "Snake",
         "R.J. McReady", "Jack Burton", "McCabe"],
        
        ["Select One", "Shut", "Jacket", "Shining", "Lyndon", "Orange", "Odyssey",
         "Strangelove", "Lolita", "Spartacus", "Glory", "Killers", "Kiss", "Seafarers",
         "Desire", "Padre", "Fight"],
        
        ["Select One", "Unknown", "Closer", "Preston", "Les", "Fractured", "Re-fractured", "Still", "Substance", "Warsaw", "Permanent", "Heart", "Total"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        answerField.delegate = self
        pickerView.delegate = self
        pickerView.dataSource = self
        
        progressBar.progress = 0.0
        questionLabel.text = questionManager.loadQuestion()
        pickerView.isHidden = true
        RNGLabel.isHidden = true
    }
    
    func nextQuestion() {
        if questionManager.index < questionManager.questionairre.count - 1 {
            questionManager.index += 1
            
            if (questionManager.isInput()) { // text field
                // change to text field
                answerField.isHidden = false
                // make picker and rng disappear
                pickerView.isHidden = true
                RNGLabel.isHidden = true
                
                // reset answer field
                answerField.text = ""
                answerField.placeholder = "Answer goes here"
                
                // number pad
//                if questionManager.index == 5 {
//                    answerField.keyboardType = .asciiCapableNumberPad
//                }
            } else if (questionManager.isPicker()) { // picker
                // change to picker
                pickerView.isHidden = false
                pickerView.reloadAllComponents()
                
                // make text field and RNG disappear
                answerField.isHidden = true
                RNGLabel.isHidden = true
            } else if (questionManager.isCommand()) { // command
                // change to RNG command
                answerField.isHidden = true
                pickerView.isHidden = true
                RNGLabel.isHidden = false
                // add another view for numbers or some shit, idk man its late lol
                RNGLabel.text = "Waiting for pressed button..."
            }
            questionLabel.text = questionManager.loadQuestion()
        }
        else {
            showResults()
        }
    }
    
    func showResults() {
        let result = nameCalculator.calculate()
        questionLabel.text = "Your Kojima name is:\n \(result).\n Congrats."
        
        leftButtonConstraint.constant = 60
        rightButtonConstraint.constant = 60
        continueButton.setImage(nil, for: .normal)
        continueButton.setTitle("Play Again", for: .normal)
        answerField.isHidden = true
        pickerView.isHidden = true
        RNGLabel.isHidden = true
    }
    
    func resetQuestions() {
        leftButtonConstraint.constant = 120
        rightButtonConstraint.constant = 120
        continueButton.setImage(UIImage(systemName: "checkmark.rectangle.fill"), for: .normal)
        continueButton.setTitle(nil, for: .normal)
        questionManager.index = -1
        nextQuestion()
        nameCalculator.answers = []
        nameCalculator.answerIndex = 0
        progressBar.progress = 0.0
        pickerCount = 0
        pickerView.reloadAllComponents()

        let xPosition = 19 // return to original position
        let yPosition = snakeBox.frame.origin.y

        let width = snakeBox.frame.size.width
        let height = snakeBox.frame.size.height
        
        snakeBox.frame = CGRect(x: CGFloat(xPosition), y: yPosition, width: width, height: height)
    }
    
    @IBAction func continuePressed(_ sender: UIButton) {
        // continue and the picker view is shown
        if !pickerView.isHidden {
            // check if picker is not "Select One" option
            if (pickerView.selectedRow(inComponent: 0) == 0) {
                presentAlert(isPicker: true)
                playSound(soundName: K.MGS)
                return
            }
            
            input = pickerValues[pickerCount][pickerView.selectedRow(inComponent: 0)]
            pickerCount += 1
            
            // store answer somewhere and move on
            nameCalculator.storeAnswers(input)
            nextQuestion()
            progressSnake()
            return
        }
        // continue and the answer view is shown
        else if !answerField.isHidden {
            if answerField.text! != "" {
                // store answer somewhere and move on
                nameCalculator.storeAnswers(answerField.text!)
                nextQuestion()
                progressSnake()
                
            } else {
                presentAlert(isPicker: false)
                playSound(soundName: K.MGS)
                answerField.placeholder = "Please type something!"
            }
        }
        
        // continue and the RNG view is shown
        else if !RNGLabel.isHidden {
            
            // label should shuffle for 3 seconds between numbers and give final value of number
            
            var tuple = ("", 0)
            switch questionManager.index {
            case 21:
                tuple = nameCalculator.getManCondition()
            case 22:
                tuple = nameCalculator.getCloneCondition()
            case 23:
                tuple = nameCalculator.getConditionCondition()
            case 24:
                tuple = nameCalculator.getKojimaCondition()
            case 25:
                tuple = nameCalculator.getNameCategory()
            default:
                break
            }
            
            let resultStr = tuple.0
            let resultDice = tuple.1
            
            UIView.transition(with: RNGLabel, duration: 0.25, options: .transitionFlipFromLeft,
                animations: { [weak self] in
                    self?.RNGLabel.text = "\(resultDice): \n \(resultStr)"
                }, completion: nil)
            
            continueButton.isEnabled = false
            let seconds = 1.5
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                // Put your code which should be executed with a delay here
                self.continueButton.isEnabled = true
                self.nextQuestion()
                self.progressSnake()
            }
            
        }
        
        // everything is hidden
        else {
            // play again pressed, reset everything
            resetQuestions()
            return
        }
    }
    
    

    // MARK: - Sound + Alert Methods

    func playSound(soundName: String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player!.play()
    }

    func presentAlert(isPicker: Bool) {
        if (isPicker){
            let alert = UIAlertController(title: "You have not picked anything yet.", message: "Please pick an option in order to continue.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))

            present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "You have not entered anything yet.", message: "Please type something in order to continue.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))

            present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: - Progress Bar
    func progressSnake() {
        let progressFloat = Float(self.questionManager.index) / Float(self.questionManager.questionairre.count)
        
//        let xPosition = snakeBox.frame.origin.x // Slide right
//        let yPosition = snakeBox.frame.origin.y
//
//        let width = snakeBox.frame.size.width
//        let height = snakeBox.frame.size.height
        
        UIView.animate(withDuration: 1.0) {
            self.progressBar.setProgress(progressFloat, animated: true)
        }

        UIView.animate(withDuration: 1.0, animations: {
//            self.snakeBox.frame = CGRect(x: xPosition, y: yPosition, width: width, height: height)
            self.snakeBox.center.x += 12
        })
    }
}

// MARK: - Dismiss Keyboard

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - UITextField Methods

extension QuestionViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        answerField.resignFirstResponder()
        continuePressed(continueButton)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if (answerField.text != "") {
            return true
        } else {
            answerField.placeholder = "Please type something!"
            return false
        }
    }
    
    // set character limit to 40
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentCharacterCount = textField.text?.count ?? 0
        if range.length + range.location > currentCharacterCount {
            return false
        }
        let newLength = currentCharacterCount + string.count - range.length
        return newLength <= 40
    }
}

// MARK: - UIPickerViewDelegate Methods

extension QuestionViewController: UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        // always scrolling thru one column
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // how many rows to select from
        return pickerValues[pickerCount].count
    }
}

// MARK: - UIPickerViewDataSource Methods

extension QuestionViewController: UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // display title for picker row
        return pickerValues[pickerCount][row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // put into array
        input = pickerValues[pickerCount][pickerView.selectedRow(inComponent: 0)]
    }
}
