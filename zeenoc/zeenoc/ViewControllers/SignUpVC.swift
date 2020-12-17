//
//  SignUpVC.swift
//  zeenoc
//
//  Created by Helal Chowdhury on 12/17/20.
//

import UIKit

class SignUpVC: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var accountSegmentedControl: UISegmentedControl!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func signUpTapped(_ sender: Any) {
    }
    

}
