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
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var snakeBox: UIImageView!
    
    var questionManager = QuestionManager()
    var nameCalculator = NameCalculator()
    var player: AVAudioPlayer?
    
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
    var input = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        progressBar.progress = 0.0
        
        answerField.delegate = self
        pickerView.delegate = self
        pickerView.dataSource = self
        questionLabel.text = questionManager.loadQuestion()
        pickerView.isHidden = true
    }
    
    func nextQuestion() {
        if questionManager.index < questionManager.questionairre.count - 1 {
            questionManager.index += 1
            
            if (!questionManager.isPicker()) { // text field
                // change to text field
                answerField.isHidden = false
                // make picker disappear
                pickerView.isHidden = true
                
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
                
                // make text field disappear
                answerField.isHidden = true
            }
            questionLabel.text = questionManager.loadQuestion()
        }
        else {
            let result = nameCalculator.calculate()
            questionLabel.text = "Your Kojima name is:\n \(result).\n Congrats."
            answerField.isHidden = true
            pickerView.isHidden = true
        }
    }
    
    @IBAction func continuePressed(_ sender: UIButton) {
        if answerField.isHidden {
            if pickerView.isHidden {
                return
            }
            
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
        let xPosition = snakeBox.frame.origin.x + 15 // Slide right + 15px
        let yPosition = snakeBox.frame.origin.y

        let width = snakeBox.frame.size.width
        let height = snakeBox.frame.size.height
        
        UIView.animate(withDuration: 1.0) {
            self.progressBar.setProgress(Float(self.questionManager.index) / Float(self.questionManager.questionairre.count), animated: true)
        }

        UIView.animate(withDuration: 1.0, animations: {
            self.snakeBox.frame = CGRect(x: xPosition, y: yPosition, width: width, height: height)
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
