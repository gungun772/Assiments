//
//  question.swift
//  personalityQuiz
//
//  Created by Student on 25/07/25.
//

import Foundation
enum ResponseType{
    case single,multiple,ranged
}

enum AnimalType : Character{
    case lion="🦁", cat="🐱" , rabbit="🐰", turtle="🐢"
    
    var definition: String{
        switch self{
        case .lion:
            return "You are incredibly outgoing. you surround yourself with the people you love and enjoy activies with your friends."
        case .cat:
            return "Mischievous, yet mild-tempered, you enjoy doing things on your own terms."
        case .rabbit:
            return "you love everything that's soft. you are healthy and full of energy."
        case .turtle:
            return "you are wise beyond your years, and you focus on the details. slow and steady wins the race."
        }
    }
}

struct Answer{
    var text: String
    var type: AnimalType
}
struct Question{
    var text:String
    var type: ResponseType
    var answer: [Answer]
}
