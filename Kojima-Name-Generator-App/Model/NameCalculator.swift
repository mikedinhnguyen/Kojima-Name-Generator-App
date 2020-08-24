//
//  NameCalculator.swift
//  Kojima-Name-Generator-App
//
//  Created by Mike Nguyen on 8/20/20.
//  Copyright © 2020 Mike Nguyen. All rights reserved.
//

import Foundation

struct NameCalculator {
    
    let commands = [
        "Press continue to 'roll the dice' to determine your -man condition.",
        "Press continue to 'roll the dice' to determine your clone condition.",
        "Press contine to 'roll the dice' to determine your condition condition."
    ]
    
    var answerIndex = 0
    var answers = [String]()
    
    mutating func storeAnswers(_ answer: String) {
        answers.insert(answer, at: answerIndex)
        print(answers[answerIndex])
        answerIndex += 1
    }
    
    func calculate() -> String {
//        let man = getManCondition()
//        let clone = getCloneCondition()
//        let condition = getConditionCondition()
        return "\(answers[11]) \(answers[12])"
    }
    
    // MARK: - Condition Methods
    
    func getManCondition() -> Bool {
        print("Press continue to 'roll the dice' to determine your -man condition.")
        
        let resultDice = Int.random(in: 1...4)
        if (resultDice < 4){
            print("You do not have the -man condition.")
            return false
        }
        else {
            print("You do have the -man condition.")
            return true
        }
    }
    func getCloneCondition() -> Bool {
        print("Press continue to 'roll the dice' to determine your clone condition.")
        
        let resultDice = Int.random(in: 1...12)
        if (resultDice < 12){
            print("You do not have the clone condition.")
            return false
        }
        else {
            print("You have the clone condition. You are a clone of someone else, or you have been brainwashed into becoming a mental doppelganger of someone else. Find someone who has completed this questionnaire and replace 50 percent of your Kojima name with 50 percent of their Kojima name.")
            return true
        }
    }
    func getConditionCondition() -> Bool {
        print("Press contine to 'roll the dice' to determine your condition condition.")
        
        let resultDice = Int.random(in: 1...8)
        if (resultDice < 6){
            print("You do not have the condition condition.")
            return false
        }
        else if (resultDice == 6){
            //condition_condition_type = "Big";
            print("You're big. You have the 'Big' condition.")
            return true
        }
        else if (resultDice == 7){
            //condition_condition_type = "Old";
            print("You are older than you once were. You have the 'Old' condition.")
            return true
        }
        else {
            //condition_condition_type = entry2_11;
            print("You are how you currently are. You have the 'condition' condition.")
            // you have the \(condition_condition_type) condition
            return true
        }
    }
}
