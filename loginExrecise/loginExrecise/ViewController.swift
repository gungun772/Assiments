//
//  ViewController.swift
//  loginExrecise
//
//  Created by Student on 18/07/25.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var usernamefiled: UITextField!
    
    @IBOutlet weak var ForgotUsernameButton: UIButton!
    
    
    @IBOutlet weak var ForgotPasswordButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func forgotbuttonpressed(_ sender: UIButton) {
        performSegue(withIdentifier: "loginpage", sender: sender)
        
    }
    @IBAction func forgotpasswordbuttonpressed(_ sender: UIButton) {
        performSegue(withIdentifier: "loginpage", sender: sender)
    }
    override func prepare(for segue: UIStoryboardSegue , sender: Any?){
        guard let sender = sender as? UIButton else{return}
        if sender == ForgotUsernameButton{
            segue.destination.navigationItem.title="Forgot username"
        }
        else if sender == ForgotPasswordButton{
            segue.destination.navigationItem.title="Forgot Password"
        }else{
            segue.destination.navigationItem.title=usernamefiled.text
        }
    }
}

