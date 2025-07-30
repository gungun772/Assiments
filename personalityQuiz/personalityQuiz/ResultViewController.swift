//
//  ResultViewController.swift
//  personalityQuiz
//
//  Created by Student on 23/07/25.
//

import UIKit

class ResultViewController: UIViewController {
    @IBOutlet weak var ResultAnswerLabel: UILabel!
    
    @IBOutlet weak var ResultDefinitionLabel: UILabel!
    
    var responses: [Answer]
    init?(coder:NSCoder, responses: [Answer]){
        self.responses=responses
        super.init(coder:coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        calculatePersonalityResult();
        navigationItem.hidesBackButton=true

        // Do any additional setup after loading the view.
    }
    func calculatePersonalityResult(){
        let frequencyOfAnswers=responses.reduce(into:[AnimalType: Int]()){
            (counts,answer) in
            if let existingCount=counts[answer.type]{
                counts[answer.type]=existingCount+1}
            else{
                counts[answer.type]=1
            }
            
        }
        let mostCommonAnswer=frequencyOfAnswers.sorted{
            $0.1 > $1.1
        }.first!.key
        ResultAnswerLabel.text="you are a \(mostCommonAnswer.rawValue)!"
        ResultDefinitionLabel.text=mostCommonAnswer.definition
    }
  
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
