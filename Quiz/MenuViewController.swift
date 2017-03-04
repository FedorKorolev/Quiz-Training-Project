//
//  MenuViewController.swift
//  Quiz
//
//  Created by Фёдор Королёв on 04.03.17.
//  Copyright © 2017 Фёдор Королёв. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    @IBOutlet weak var quizTableView: UITableView!
    
    
    var quizList: [String]?

    private func setup() {
        quizTableView.dataSource = self
        quizTableView.delegate = self
        
        loadQuizList()
    }
    
    private func loadQuizList() {
        quizList = ["animals","cinema"]
        print("Quiz Lise: \(quizList)")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destVC = segue.destination as? QuestionsViewController,
            let selectedFileName = sender as? String? {
            destVC.fileName = selectedFileName
        }
    }
}


extension MenuViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = quizTableView.dequeueReusableCell(withIdentifier: "Quiz List Cell", for: indexPath)
        
        cell.textLabel?.text = quizList?[indexPath.row]
        
        return cell
    }
    
}

extension MenuViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedQuiz = quizList?[indexPath.row]
        
        performSegue(withIdentifier: "Start Selected Quiz", sender: selectedQuiz)
    }
    
}






