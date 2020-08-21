//
//  ViewController.swift
//  Kojima-Name-Generator-App
//
//  Created by Mike Nguyen on 8/20/20.
//  Copyright © 2020 Mike Nguyen. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerField: UITextField!
    
    var questionManager = QuestionManager()
    var nameCalculator = NameCalculator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        answerField.delegate = self
        questionLabel.text = questionManager.loadQuestion()
    }
    
    @IBAction func continuePressed(_ sender: UIButton) {
        if questionManager.index == questionManager.questionairre.count {
            answerField.text = ""
            answerField.placeholder = "You are done."
            return
        }
        if answerField.text! != "" {
            // store answer somewhere!
            nameCalculator.storeAnswers(answerField.text!)
            
            // next question
            if questionManager.index != questionManager.questionairre.count - 1 {
                questionManager.index += 1
                questionLabel.text = questionManager.loadQuestion()
            }
            else {
                let result = nameCalculator.calculate()
                questionLabel.text = "Your Kojima name is: \(result). Congrats."
                answerField.placeholder = "You are done."
            }
            
            // reset answer field
            answerField.text = ""
            answerField.placeholder = "Answer goes here"
        } else {
            answerField.placeholder = "Please type something!"
        }
    }

}

// MARK: - UITextFieldDelegate Methods

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
