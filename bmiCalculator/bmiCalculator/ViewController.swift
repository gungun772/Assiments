//
//  ViewController.swift
//  bmiCalculator
//
//  Created by Student on 14/07/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var weightText: UITextField!
    
    
    @IBOutlet weak var heightText: UITextField!
    
    
    @IBOutlet weak var calculatorBMI: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func calculateButtonPressed(_ sender: Any) {
        let weightString=weightText.text ?? ""
        let weight=Double(weightString) ?? 0
        let heightString=heightText.text ?? ""
        let height=Double(heightString) ?? 0
        let bmi=weight/(height*height)
        calculatorBMI.text="BMI is: \(bmi)"
    }
    

}

