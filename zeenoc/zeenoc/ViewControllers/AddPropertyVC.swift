//
//  AddPropertyVC.swift
//  zeenoc
//
//  Created by Helal Chowdhury on 1/10/21.
//

import UIKit

class AddPropertyVC: UIViewController {

    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var bedroomTextField: UITextField!
    @IBOutlet weak var bathroomTextField: UITextField!
    @IBOutlet weak var squareFootTextField: UITextField!
    @IBOutlet weak var rentTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupElements()

    }
    
    func setupElements() {
        
        Utilities.styleTextField(addressTextField)
        Utilities.styleTextField(bedroomTextField)
        Utilities.styleTextField(bathroomTextField)
        Utilities.styleTextField(squareFootTextField)
        Utilities.styleTextField(rentTextField)
        Utilities.styleTextField(descriptionTextField)
        Utilities.styleFilledButton(registerButton)
        
    }

}
