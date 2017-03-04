//
//  Question.swift
//  Quiz
//
//  Created by Фёдор Королёв on 04.03.17.
//  Copyright © 2017 Фёдор Королёв. All rights reserved.
//

/*
 {
 "question":"Кто это?",
 "answers":["Скарлетт Йоханссон", "Анджелина Джоли","Дженнифер Энистон","Натали Портман"],
 "correctAnswer":"Скарлетт Йоханссон",
 "image":"firstsQuestion"
}
*/

// 3D

import UIKit

struct Question {
    let title: String
    let answers: [String]
    private let correctAnswer: String
    
    private let imageName: String
    var image: UIImage? {
        return UIImage(named: imageName)
    }
    
    init?(json: [String:Any]) {
        guard let title = json["question"] as? String,
              let imageName = json["image"] as? String,
              let correctAnswer = json["correctAnswer"] as? String,
              let answers = json["answers"] as? [String],
              answers.contains(correctAnswer)
        else {
            return nil
        }
        self.title = title
        self.imageName = imageName
        self.answers = answers
        self.correctAnswer = correctAnswer
    }
    
    func answerIsCorrect(answer: String?) -> Bool {
        return correctAnswer == answer
    }
}





