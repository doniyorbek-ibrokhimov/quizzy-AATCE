//
//  ViewController.swift
//  quizzy
//
//  Created by DONIYORBEK IBROKHIMOV on 14/03/23.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var optionsTableView: UITableView!
    
    let questionUrl = "https://opentdb.com/api.php?amount=10&category=18&difficulty=easy&type=multiple"
    var questionDataJSON = JSON()
    var allOptions: [String] = []
    
    var data: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        populate()
        
        getQuestionData()
        
        optionsTableView.delegate = self
        optionsTableView.dataSource = self
    }
    
    //MARK: Networking
    func getQuestionData() {
        AF.request(questionUrl, method: .get).responseJSON { response in
            
            switch response.result {
            case .success(let safeResult):
                self.questionDataJSON = JSON(safeResult)
                self.updateQuestionData()
                
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    func updateQuestionData() {
        var question: String
        var correctAnswer: String
        
//        results[0].question
//        results[1].question
        
        question = questionDataJSON["results"][0]["question"].stringValue
        
//        results[0].correct_answer
//        results[0].correct_answer
        correctAnswer = questionDataJSON["results"][0]["correct_answer"].stringValue
        allOptions.append(correctAnswer)
        
//        results[0].incorrect_answers
        for i in 0...2 {
            let incorrectAnswer = questionDataJSON["results"][0]["incorrect_answers"][i].stringValue
            allOptions.append(incorrectAnswer)
        }
        
        allOptions.shuffle()
        
        
    }
    
    func updateUI(with question: String) {

    }
    
    

    @IBAction func nextButtonPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        getQuestionData()
    }
    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func populate() {
        var strElem: String
        
        for i in 0...100 {
            strElem = String(i)
            data.append(strElem)
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("numberOfRowsInSection")
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let option = data[indexPath.row]
        print("cellForRowAt")
        print(indexPath.row)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "OptionCell") as! OptionCell
        
        cell.setOption(option)
        
        return cell
    }
    
    
    
}


