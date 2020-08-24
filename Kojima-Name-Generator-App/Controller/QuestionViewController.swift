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
        
        answerField.delegate = self
        pickerView.delegate = self
        pickerView.dataSource = self
        questionLabel.text = questionManager.loadQuestion()
        pickerView.isHidden = true
    }
    
    func nextQuestion() {
        if questionManager.index < questionManager.questionairre.count - 1 {
            questionManager.index += 1
            if (!questionManager.isPicker()) {
                // change to text field
                answerField.isHidden = false
                // make picker disappear
                pickerView.isHidden = true
                // reset answer field
                answerField.text = ""
                answerField.placeholder = "Answer goes here"
            } else if (questionManager.isPicker()) {
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
            questionLabel.text = "Your Kojima name is: \(result). Congrats."
            answerField.isHidden = true
            pickerView.isHidden = true
        }
    }
    
    // mp3 alert
    
    func playSound(soundName: String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player!.play()
    }
    
    @IBAction func continuePressed(_ sender: UIButton) {
        if answerField.isHidden {
            // check if 0
            if (pickerView.selectedRow(inComponent: 0) == 0) {
                print("not possible")
                playSound(soundName: K.MGS)
                return
            }
            
            input = pickerValues[pickerCount][pickerView.selectedRow(inComponent: 0)]
            pickerCount += 1
            nameCalculator.storeAnswers(input)
            nextQuestion()
            return
        }
        if answerField.text! != "" {
            // store answer somewhere!
            nameCalculator.storeAnswers(answerField.text!)
            
            // next question
            nextQuestion()
            
        } else {
            playSound(soundName: K.MGS)
            answerField.placeholder = "Please type something!"
        }
        
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
}

// MARK: - UIPickerViewDelegate Methods

extension QuestionViewController: UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        // always scrolling thru one column
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // how many rows to select from
        print(pickerValues[pickerCount].count)
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
