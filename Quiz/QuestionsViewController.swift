//
//  QuestionsViewController.swift
//  Quiz
//
//  Created by Фёдор Королёв on 04.03.17.
//  Copyright © 2017 Фёдор Королёв. All rights reserved.
//

import UIKit

class QuestionsViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var questionText: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var questionList: [Question]? {
        // Когда сюда будут записаны новые вопросы, возьмем первый из них и запишем в currentQuestion
        didSet {
            currentQuestionIndex = 0
            currentQuestion = questionList?.first
        }
    }
    
    var currentQuestionIndex = 0
    var currentQuestion: Question? {
        didSet {
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        
    }

    //MARK: Setup
    
    private func setup() {
        
        // Станем делегатом для View
        tableView.dataSource = self // что показывать?
        tableView.delegate = self // как реагировать на события?

        loadData()
        
        
    }
    
    private func updateViews() {
        self.tableView.reloadData()
        questionText.text = currentQuestion?.title
        imageView.image = currentQuestion?.image
    }
    
    private func loadData() {
        let loader = DataLoader()
        let result = loader.loadData(fileName: "cinema")
        print(result)
        
        self.title = result.quizName
        self.questionList = result.questions
    }
    
    
}


// Поддержка протокола UITableViewDataSource
extension QuestionsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Если нет текущего вопроса, мы передадим значение по-умолчанию
        return currentQuestion?.answers.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Запросим у tableView ячейку с определённым илентификатором
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        // В ячейках таблицы будут отображаться ответы на вопрос. Одна ячейка — один ответ.
        cell.textLabel?.text = currentQuestion?.answers[indexPath.row]
        
        return cell
    }
}

// Поддержка протокола делегата
extension QuestionsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Ячейка с индексом \(indexPath) выбрана")
        
        // Перейти к следующему вопросу
        currentQuestionIndex += 1
        currentQuestion = questionList?[currentQuestionIndex]
    }
}





