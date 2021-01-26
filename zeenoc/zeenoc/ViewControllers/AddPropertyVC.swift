//
//  AddPropertyVC.swift
//  zeenoc
//
//  Created by Helal Chowdhury on 1/10/21.
//

import UIKit
import Firebase

class AddPropertyVC: UIViewController {

    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var deadlineTextField: UITextField!
    @IBOutlet weak var rentTextField: UITextField!
    @IBOutlet weak var roomTextField: UITextField!
    @IBOutlet weak var bathTextField: UITextField!
    @IBOutlet weak var squareFeetTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupElements()

    }
    
    func setupElements() {
        
        Utilities.styleTextField(addressTextField)
        Utilities.styleTextField(deadlineTextField)
        Utilities.styleTextField(rentTextField)
        Utilities.styleTextField(roomTextField)
        Utilities.styleTextField(bathTextField)
        Utilities.styleTextField(squareFeetTextField)
        Utilities.styleFilledButton(registerButton)
        
    }

    @IBAction func registerTapped(_ sender: Any) {
        
        let db = Firestore.firestore()
        let user = Auth.auth().currentUser?.uid
        db.collection("users").document(user!).collection("properties").addDocument(data: [
            "address": addressTextField.text!,
            "deadline": deadlineTextField.text!,
            "rent": rentTextField.text!,
            "room": roomTextField.text!,
            "bath": bathTextField.text!,
            "squareFoot": squareFeetTextField.text!
        ])
        
    }
}
