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
        
        Question(question: "What do you do at your occupation?", type: "input"),
        
        Question(question: "What was your first pet's specfic species/breed? If you never had a pet, please answer with an animal you wish you owned.", type: "input"),
        
        Question(question: "Think of the most embarassing childhood memory you have had. Condense that memory down to two words.", type: "input"),
        
        Question(question:"What is the object you would least like to be stabbed by?", type:"input"),

        Question(question:"What is something you are good at? (verb ending in '-ing')", type:"input"),

        Question(question:"How many carrots do you believe you could eat in one sitting, if someone, like, forced you to eat as many carrots as possible?", type:"inputNum"),
        
        Question(question:"What is your greatest intangible fear? (e.g. death, loneliness, fear itself)", type:"input"),

        Question(question:"What is your greatest tangible fear?", type:"input"),

        Question(question:"What is the last thing you did before starting this questionnaire?", type:"input"),

        Question(question:"What condition is your body currently in? (single word answer)", type:"input"),

        Question(question:"Favorite state of matter?", type:"picker"),

        Question(question:"A word your name kind of sounds like? (e.g. Jenny -> Penny)", type:"input"),

        Question(question:"What is your Zodiac sign?", type:"picker"),

        Question(question:"If you had to define your personality in one word, what would it be?", type:"input"),
        
        Question(question:"Who is your favorite film character? (NOTE: must be played by Kurt Russell)", type:"picker"),

        Question(question:"What is the last word of the title of your favorite Kubrick film?", type:"picker"
        ),

        Question(question:"What is the first word in the title of your favorite Joy Division album?", type:"picker"
        ),
        
        Question(question:"What is a scientific term you picked up from listening to NPR once?", type:"input"
        ),

        Question(question:"What is a piece of military hardware you think looks cool even though war is bad?", type:"input"),

        Question(question:"What is something you would enjoy watching Mads Mikkelsen do? Please condense into one word.", type:"input")

    ]

    var index = 0
    
    func loadQuestion() -> String {
        return questionairre[index].question
    }
}
