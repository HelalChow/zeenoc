//
//  StartVC.swift
//  zeenoc
//
//  Created by Helal Chowdhury on 12/17/20.
//

import UIKit

class StartVC: UIViewController {

    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupElements()
    }
    
    func setupElements() {
        Utilities.styleFilledButton(signUpButton)
        Utilities.styleFilledButton(loginButton)
    }


}
