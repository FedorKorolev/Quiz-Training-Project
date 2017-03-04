//
//  TableDemoViewController.swift
//  Quiz
//
//  Created by Фёдор Королёв on 04.03.17.
//  Copyright © 2017 Фёдор Королёв. All rights reserved.
//

import UIKit

class TableDemoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Делегируем работу с таблицей классу
        tableView.dataSource = self
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    // Данные
    var strings = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.".components(separatedBy: " ") // Делим на массив строк по словам.

}


// Реализуем поддержку классом протокола UITableViewDataSource
extension TableDemoViewController: UITableViewDataSource {
    
    // Метод запрашивает число элементов в секции таблицы
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return strings.count
    }
    
    // Ядро работы с таблицей
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Запросим у таблицы ячейку с идентификатором, который мы указали в сториборд. Нам вернут прототип ячейки, который можно поднастроить под конкретный элемент массива строк
        let cell = tableView.dequeueReusableCell(withIdentifier: "Basic Cell", for: indexPath)
        
        // Настроим нашу ячейку. row - индекс ячейки внутри секции
        let strToShow = strings[indexPath.row]
        
        // indexPath.section - номер секции
        
        //Зададим текст в ячейке, используя конкретную строку
        cell.textLabel?.text = "\(indexPath.row) = \(strToShow)"
        
        return cell
    }
}















