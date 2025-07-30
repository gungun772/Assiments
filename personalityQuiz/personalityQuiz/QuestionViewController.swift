//
//  QuestionViewController.swift
//  personalityQuiz
//
//  Created by Student on 23/07/25.
//

import UIKit

class QuestionViewController: UIViewController {

    
    @IBOutlet weak var commonLabel: UILabel!
    
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet weak var singleButton1: UIButton!
    @IBOutlet weak var singleButton2: UIButton!
    @IBOutlet weak var singleButton3: UIButton!
    @IBOutlet weak var singleButton4: UIButton!
    
    @IBOutlet weak var multipleStackview: UIStackView!
    @IBOutlet weak var multipleLabel1: UILabel!
    @IBOutlet weak var multipleLabel2: UILabel!
    @IBOutlet weak var multipleLabel3: UILabel!
    @IBOutlet weak var multipleLabel4: UILabel!
    
    @IBOutlet weak var multipleSwitch1: UISwitch!
    @IBOutlet weak var multipleSwitch2: UISwitch!
    @IBOutlet weak var multipleSwitch3: UISwitch!
    @IBOutlet weak var multipleSwitch4: UISwitch!
    
    @IBOutlet weak var rangeStackView: UIStackView!
    @IBOutlet weak var rangeLabel1: UILabel!
    @IBOutlet weak var rangeLabel2: UILabel!
    
    @IBOutlet weak var rangeSlider: UISlider!
    
    @IBOutlet weak var questionProgressView: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        // Do any additional setup after loading the view.
    }
    
    var question:[Question]=[
        Question(text: "which food do you like the most?", type: .single, answer: [Answer(text:"steak",type:.lion),
                                                                                Answer(text: "fish", type: .cat),
                                                                                   Answer(text: "carrots", type: .rabbit),
                                                                                   Answer(text: "corn", type: .turtle)]),
        Question(text: "which activities do you enjoy?", type: .multiple, answer: [Answer(text:"swimming",type:.turtle),
                                                                                Answer(text: "sleeping", type: .cat),
                                                                                   Answer(text: "cuddling", type: .rabbit),
                                                                                   Answer(text: "eating", type: .lion)]
                ),
        Question(text: "How much do you enjoy?", type: .ranged, answer: [Answer(text:"I barley notice them",type:.turtle),
                                                                                Answer(text: "i dislike them", type: .cat),
                                                                                   Answer(text: "I get a little nervous", type: .rabbit),
                                                                                   Answer(text: "I love them", type: .lion)]),
    ]
    var questionIndex=0
    
    
    @IBSegueAction func showResults(_ coder: NSCoder) -> ResultViewController? {
        return ResultViewController(coder: coder,responses: answerChosen)
    }
    
    
    
    func updateSingleStack(using answers:[Answer]){
        singleStackView.isHidden=false
        singleButton1.setTitle(answers[0].text, for: .normal)
        singleButton2.setTitle(answers[1].text, for: .normal)
        singleButton3.setTitle(answers[2].text, for: .normal)
        singleButton4.setTitle(answers[3].text, for: .normal)
    }
    
    func updateMultipleStack(using answers: [Answer]){
        multipleStackview.isHidden=false
        multipleSwitch1.isOn=false
        multipleSwitch2.isOn=false
        multipleSwitch3.isOn=false
        multipleSwitch4.isOn=false
        multipleLabel1.text=answers[0].text
        multipleLabel2.text=answers[1].text
        multipleLabel3.text=answers[2].text
        multipleLabel4.text=answers[3].text
    }
    
    func updateRangedStack(using answers: [Answer]){
        rangeStackView.isHidden=false
        rangeSlider.setValue(0.5,animated: false)
        rangeLabel1.text=answers.first?.text
        rangeLabel2.text=answers.last?.text
    }
    func updateUI(){
        let currentQuestion=question[questionIndex]
        let currentAnswer=currentQuestion.answer
        let totalProgress=Float(questionIndex)/Float(question.count)
        singleStackView.isHidden=true
        multipleStackview.isHidden=true
        rangeStackView.isHidden=true
        navigationItem.title="Question #\(questionIndex+1)"
        commonLabel.text=currentQuestion.text
        questionProgressView.setProgress(totalProgress, animated: true)
       
        switch currentQuestion.type{
        case .single:
            updateSingleStack(using: currentAnswer)
        case .multiple:
           updateMultipleStack(using: currentAnswer)
        case .ranged:
            updateRangedStack(using: currentAnswer)
        }
    }
    
    var answerChosen: [Answer]=[]
    func nextQuestion(){
        questionIndex+=1
        if questionIndex < question.count{
            updateUI()
        }else{
            performSegue(withIdentifier: "Results", sender: nil)
        }
    }
    @IBAction func SingleAnswerChoosenStack(_ sender: UIButton) {
        let currentAnswers=question[questionIndex].answer
        switch sender{
        case singleButton1:
            answerChosen.append(currentAnswers[0])
        case singleButton2:
            answerChosen.append(currentAnswers[1])
        case singleButton3:
            answerChosen.append(currentAnswers[2])
        case singleButton4:
            answerChosen.append(currentAnswers[3])
        default:
            break
        }
        nextQuestion()
    }
    @IBAction func multipleButtonSwitchPressed(_ sender: Any) {
        let currentAnswers=question[questionIndex].answer
        if multipleSwitch1.isOn{
            answerChosen.append(currentAnswers[0])
        }
        if multipleSwitch2.isOn{
            answerChosen.append(currentAnswers[1])
        }
        if multipleSwitch3.isOn{
            answerChosen.append(currentAnswers[2])
        }
        if multipleSwitch4.isOn{
            answerChosen.append(currentAnswers[3])
        }
        nextQuestion()
    }
    
    @IBAction func rangedButtonPressed(_ sender: Any) {
        let currentAnswers=question[questionIndex].answer
        let index=Int(round(rangeSlider.value *  Float(currentAnswers.count-1)))
        answerChosen.append(currentAnswers[index])
        nextQuestion()
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
