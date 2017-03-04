//
//  DataLoader.swift
//  Quiz
//
//  Created by Фёдор Королёв on 04.03.17.
//  Copyright © 2017 Фёдор Королёв. All rights reserved.
//

import Foundation

class DataLoader {
    
/*
 1. Открыть файл
 2. Преобразовать его в Dictionary[String:Any]
 3. Достать оттуда вопросы и название викторины
*/
    func loadData(fileName: String) -> (quizName: String, questions: [Question]) {
        
        // 1. Открыть файл.
        // найти путь к искомому файлу
        let pathToFile = Bundle.main.path(forResource: fileName, ofType: "json")!
        
        // путь к файлу внутри приложения
        print(pathToFile)
        
        // Прочитать сырой поток байт из найденного пути
        let data = try! Data(contentsOf: URL(fileURLWithPath: pathToFile))
        
        // Получить объект типа Any, который почти готов к использованию
        let json = try! JSONSerialization.jsonObject(with: data, options: [])
        
        // Привести тип Any в словарь
        guard let questionsJson = json as? [String:Any] else {
            fatalError("Некорректный объект с вопросами: \(json)")
        }
        
        // Получить название и массив вопров
        guard let quizName = questionsJson["name"] as? String,
              let jsonsToConvert = questionsJson["questions"] as? [ [String:Any] ] else {
                fatalError("Некорректный формат викторины")
        }
        
        // Пустой массив вопросов
        var questions = [Question]()
        
        //Заполнить массив вопросов
        for json in jsonsToConvert {
            if let aQuestion = Question(json: json) {
                questions.append(aQuestion)
            }
        }
        
        if questions.count == 0 {
            fatalError("Не создано ни одного вопроса")
        }
        
        return (quizName, questions)
        
    }
    
}
