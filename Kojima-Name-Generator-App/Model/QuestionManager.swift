//
//  QuestionManager.swift
//  Kojima-Name-Generator-App
//
//  Created by Mike Nguyen on 8/20/20.
//  Copyright © 2020 Mike Nguyen. All rights reserved.
//

import Foundation

struct QuestionManager {
    
    let questionairre = [
        Question(question: "What is your full name?", type: "input"),
        // 0, 2_1
        
        Question(question: "What do you do at your occupation? (condense to a single '-er' noun)", type: "input"),
        // 1, 2_2
        
        Question(question: "What was your first pet's specfic species/breed? If you never had a pet, please answer with an animal you wish you owned.", type: "input"),
        // 2, 2_3
        
        Question(question: "Think of the most embarassing childhood memory you have had. Condense that memory down to two words.", type: "input"),
        // 3, 2_4
        
        Question(question:"What is the object you would least like to be stabbed by?", type:"input"),
        // 4, 2_5

        Question(question:"What is something you are good at? (verb ending in '-ing')", type:"input"),
        // 5, 2_6

        Question(question:"How many carrots do you believe you could eat in one sitting, if someone, like, forced you to eat as many carrots as possible?", type:"input"),
        // 6, 2_7
        
        Question(question:"What is your greatest intangible fear? (e.g. death, loneliness, fear itself)", type:"input"),
        // 7, 2_8

        Question(question:"What is your greatest tangible fear?", type:"input"),
        // 8, 2_9

        Question(question:"What is the last thing you did before starting this questionnaire?", type:"input"),
        // 9, 2_10

        Question(question:"What condition is your body currently in? (single word answer)", type:"input"),
        // 10, 2_11

        Question(question:"Favorite state of matter?", type:"picker"),
        // 11, 2_12

        Question(question:"A word your name kind of sounds like? (e.g. Jenny -> Penny)", type:"input"),
        // 12, 2_13

        Question(question:"What is your Zodiac sign?", type:"picker"),
        // 13, 2_14

        Question(question:"If you had to define your personality in one word, what would it be?", type:"input"),
        // 14, 2_15
        
        Question(question:"Who is your favorite film character? (NOTE: must be played by Kurt Russell)", type:"picker"),
        // 15, 3_16

        Question(question:"What is the last word of the title of your favorite Kubrick film?", type:"picker"),
        // 16, 3_17

        Question(question:"What is the first word in the title of your favorite Joy Division album?", type:"picker"),
        // 17, 3_18
        
        Question(question:"What is a scientific term you picked up from listening to NPR once?", type:"input"),
        // 18, 3_19

        Question(question:"What is a piece of military hardware you think looks cool even though war is bad?", type:"input"),
        // 19, 3_20

        Question(question:"What is something you would enjoy watching Mads Mikkelsen do? Please condense into one word.", type:"input")
        // 20, 3_21
    ]

    var index = 0
    
    func loadQuestion() -> String {
        return questionairre[index].question
    }
    
    func isPicker() -> Bool {
        if questionairre[index].type == K.type2 {
            return true
        }
        return false
    }
}
