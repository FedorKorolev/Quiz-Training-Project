//
//  ResultViewController.swift
//  Quiz
//
//  Created by Фёдор Королёв on 04.03.17.
//  Copyright © 2017 Фёдор Королёв. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    
    var score = 0 {//От 0 до 100
        didSet {
            if score < 0 {
                score = 0
            }
            if score > 100 {
                score = 100
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
        var text = ""
        
        switch score {
        case 0:         text = "Похоже, вы бот"
        case 1...30:    text = "Повезёт в другой раз"
        case 31...50:   text = "Не плохо, но и не хорошо"
        case 51...99:   text = "Отлично!"
        default:        text = "Вы точно бот"
        }
        
        resultLabel.text = "\(score)\n\(text)"
        
        progressView.setProgress((Float(score)/100), animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

   

}
