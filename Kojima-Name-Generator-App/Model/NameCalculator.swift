//
//  NameCalculator.swift
//  Kojima-Name-Generator-App
//
//  Created by Mike Nguyen on 8/20/20.
//  Copyright © 2020 Mike Nguyen. All rights reserved.
//

import Foundation

struct NameCalculator {
    
    init() {
        man = false
        clone = false
        condition = false
        kojima = false
        normal = false
        occupation = false
        horny = false
        the = false
        cool = false
        violent = false
        subtext = false
    }
    
    var answerIndex = 0
    var answers = [String]()
    var man, clone, condition, kojima: Bool
    var normal, occupation, horny, the, cool, violent, subtext: Bool
    var condition_condition_type = ""
    var first_name = ""
    var last_name = ""
    
    mutating func storeAnswers(_ answer: String) {
        answers.insert(answer, at: answerIndex)
        print(answers[answerIndex])
        answerIndex += 1
    }
    
    mutating func calculate() -> String {
        if (kojima) {return "Hideo Kojima"}
        if (normal) {return getNormalName(man, condition)}
        if (occupation) {return getOccupationName(man, condition)}
        if (horny) {return getHornyName(man, condition)}
        if (the) {return getTheName(man, condition)}
        if (cool) {return getCoolName(man, condition)}
        if (violent) {return getViolentName(man, condition)}
        if (subtext) {return getSubtextName(man, condition)}
        
        return "none"
    }
    
    // MARK: - Condition Methods
    
    mutating func getManCondition() -> (String, Int) {
        
        let resultDice = Int.random(in: 1...4)
        if (resultDice < 4){
            let str = "You do not have the -man suffix."
            print(str)
            man = false
            return (str, resultDice)
        }
        else {
            let str = "You do have the -man suffix."
            print(str)
            man = true
            return (str, resultDice)
        }
    }
    
    mutating func getCloneCondition() -> (String, Int) {
        
        let resultDice = Int.random(in: 1...12)
        if (resultDice < 12){
            let str = "You are not a clone."
            print(str)
            clone = false
            return (str, resultDice)
        }
        else {
            let str = "You are a clone of someone else, or you have been brainwashed into becoming a mental doppelganger of someone else. Find someone who has completed this questionnaire and replace 50 percent of your Kojima name with 50 percent of their Kojima name."
            print(str)
            clone = true
            return (str, resultDice)
        }
    }
    
    mutating func getConditionCondition() -> (String, Int) {

        let resultDice = Int.random(in: 1...8)
        if (resultDice < 6){
            let str = "You do not have a condition."
            print(str)
            condition = false
            return (str, resultDice)
        }
        else if (resultDice == 6){
            let str = "You're big. You have the 'Big' condition."
            condition_condition_type = "Big"
            print(str)
            condition = true
            return (str, resultDice)
        }
        else if (resultDice == 7){
            let str = "You are older than you once were. You have the 'Old' condition."
            condition_condition_type = "Old"
            print(str)
            condition = true
            return (str, resultDice)
        }
        else {
            let str = "You are how you currently are. You have the 'condition' condition."
            condition_condition_type = answers[10]
            print(str)
            condition = true
            return (str, resultDice)
        }
    }
    
    mutating func getKojimaCondition() -> (String, Int) {

        let resultDice = Int.random(in: 1...100)
        if (resultDice != 69){
            let str = "You are not Hideo Kojima."
            print(str)
            kojima = false
            return (str, resultDice)
        }
        else{
            let str = "You are Hideo Kojima!!!"
            print(str)
            kojima = true
            return (str, resultDice)
        }
    }
    
    // MARK: - Name Category Methods
    
    mutating func getNameCategory() -> (String, Int) {
        let resultDice = Int.random(in: 1...20)
        var name_category = ""
        
        if (resultDice == 1){
            normal = true
            name_category = K.name1
        }
        else if (resultDice >= 2 && resultDice <= 6){
            occupation = true
            name_category = K.name2
        }
        else if (resultDice >= 7 && resultDice <= 10){
            horny = true
            name_category = K.name3
        }
        else if (resultDice >= 11 && resultDice <= 13){
            the = true
            name_category = K.name4
        }
        else if (resultDice >= 14 && resultDice <= 17){
            cool = true
            name_category = K.name5
        }
        else if (resultDice == 18 || resultDice == 19){
            violent = true
            name_category = K.name6
        }
        else if (resultDice == 20){
            subtext = true
            name_category = K.name7
        }
        
        if (subtext != true){
            let str = "You have a \(name_category) NAME."
            print(str)
            return (str, resultDice)
        }
        else{
            let str = "You have a \(name_category)."
            print(str)
            return (str, resultDice)
        }
    }
    
    mutating func addOns(_ man: Bool, _ condition: Bool) {
        if (man){
            last_name = last_name + "man"
        }
        if (condition){
            first_name = first_name + " " + condition_condition_type
        }
    }
    
    // MARK: - Normal
    
    func getNormalName(_ man: Bool, _ condition: Bool) -> String {

        var result = answers[0]
        if (man){
            result = result + "man"
        }
        if (condition){
            result = condition_condition_type + " " + result
        }
        return result
    }
    
    // MARK: - Occupation
    
    mutating func getOccupationName(_ man: Bool, _ condition: Bool) -> String {
        last_name = answers[1]
        let resultDice = Int.random(in: 1...4)
        switch (resultDice) {
            case 1:
                first_name = answers[14]
                break
            case 2:
                first_name = answers[5]
                break
            case 3:
                first_name = answers[12]
                break
            case 4:
                first_name = answers[15]
                break
            default:
                break
        }
        addOns(man, condition)
        let result = first_name + " " + last_name;
        return result
    }
    
    // MARK: - Horny
    
    mutating func getHornyName(_ man: Bool, _ condition: Bool) -> String {
        last_name = answers[2]
        var lick = " "
        let resultDice = Int.random(in: 1...4)
        switch (resultDice) {
            case 1:
                first_name = answers[11]
                break
            case 2:
                first_name = "Naked"
                break
            case 3:
                first_name = answers[5]
                break
            case 4:
                first_name = answers[13]
                break
            default:
                break
        }
        
        if (lick == "ok") {
            lick = " 'Lickable' "
        }
        addOns(man, condition)
        let result = first_name + lick + last_name
        return result
    }
    
    // MARK: - The
    
    mutating func getTheName(_ man: Bool, _ condition: Bool) -> String {
        first_name = "The"
        let resultDice = Int.random(in: 1...4)
        switch (resultDice) {
            case 1:
                last_name = answers[7]
                break
            case 2:
                last_name = answers[8]
                break
            case 3:
                last_name = answers[3]
                break
            case 4:
                last_name = answers[19]
                break
            default:
                break
        }
        addOns(man, condition)
        let result = first_name + " " + last_name
        return result
    }
    
    // MARK: - Cool
    
    mutating func getCoolName(_ man: Bool, _ condition: Bool) -> String {
        first_name = answers[20]
        let resultDice = Int.random(in: 1...6)
        switch (resultDice) {
            case 1:
                last_name = answers[16]
                break
            case 2:
                last_name = answers[17]
                break
            case 3:
                last_name = answers[18]
                break
            case 4:
                last_name = answers[5]
                break
            case 5:
                last_name = answers[7]
                break
            case 6:
                last_name = answers[12]
                break
            default:
                break
        }
        addOns(man, condition)
        let result = first_name + " " + last_name;
        return result;
    }
    
    // MARK: - Violent
    
    mutating func getViolentName(_ man: Bool, _ condition: Bool) -> String {
        last_name = answers[4]
        let resultDice = Int.random(in: 1...4)
        switch (resultDice) {
            case 1:
                first_name = answers[18]
                break
            case 2:
                first_name = answers[11]
                break
            case 3:
                first_name = answers[19]
                break
            case 4:
                first_name = answers[8]
                break
            default:
                break
        }
        addOns(man, condition)
        let result = first_name + " " + last_name;
        return result
    }
    
    // MARK: - Subtext
    
    mutating func getSubtextName(_ man: Bool, _ condition: Bool) -> String {
        var result = answers[9]
        if (man){ result = result + "man"
        }
        if (condition){
            result = condition_condition_type + " " + result
        }
        return result
    }
    
}
