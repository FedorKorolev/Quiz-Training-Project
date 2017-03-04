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
            score = 0
            currentQuestion = questionList?.first
        }
    }
    
    var currentQuestionIndex = 0
    var currentQuestion: Question? {
        didSet {
            updateViews()
        }
    }
    
    var score = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        log(message: "Это идеальное место для подготовки к работе, когда нужно выполнить подготовку единожды за всё время жизни контроллера")
        
        setup()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        log(message: "Метод вызвается в момент, когда контроллер вот-вот появится. Как правило, тут можно подготовиться к отображению анимации")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadData()
        log(message: "Метод только что появился. Идеальное место для начала анимации.")
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        log(message: "Экран будет пропадать.")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        log(message: "Экан пропал.")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        log(message: "У устройства заканчивается оперативная память. Нужно избавляться от ресурсов, которые которые вы можете восстановить позднее.")
    }
    
    deinit {
        log(message: "Это последнее место, где контроллер что-то может сделать напоследок")
    }
    
    // Метод вызывается перед переходом на новый экран
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // если мы переходим на ResultViewController
        if let destVC = segue.destination as? ResultViewController,
            // и параметром при переходе является объект типа Int
            let scoreToShow = sender as? Int {
            destVC.score = scoreToShow
            
        }
    }

    //MARK: Setup
    
    private func setup() {
        
        // Станем делегатом для View
        tableView.dataSource = self // что показывать?
        tableView.delegate = self // как реагировать на события?

        loadData()
        
        
    }

    
    // #function — имя метода, в котором этот код выполняется
    func log(message: String, methodName: String = #function) {
        print("\n" + methodName + ": " + message + "\n")
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
        
        // Проверим ответ
        let selectedAnswer = currentQuestion?.answers[indexPath.row]
        
        // Если ответа нет, выйдет false
        if currentQuestion?.answerIsCorrect(answer: selectedAnswer) ?? false {
            score += 1
        }
        print("Ячейка с индексом \(indexPath) выбрана. Счёт \(score)")
        
        // Перейти к следующему вопросу
        currentQuestionIndex += 1
        
        guard currentQuestionIndex < (questionList?.count) ?? 0 else {
            print("Больше нет вопросов")
            
            //Вычислить счёт:
            let score = Double(self.score) / Double(questionList?.count ?? 1) * 100
            
            // Перейти на экран результатов, передав score. Перед переходом вызывается метод prepare(for segue: UIStoryboardSegue, sender: Any?)
            performSegue(withIdentifier: "Show Result", sender: Int(score))
            
            return
        }
        
        currentQuestion = questionList?[currentQuestionIndex]
    }
}





