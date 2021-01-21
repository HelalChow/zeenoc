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

    @IBAction func registerTapped(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
        
        let db = Firestore.firestore()
        let user = Auth.auth().currentUser?.uid
        db.collection("users").document(user!).collection("properties").addDocument(data: [
            "address": addressTextField.text!,
            "bedroom": bedroomTextField.text!,
            "bathroom": bathroomTextField.text!,
            "squareFoot": squareFootTextField.text!,
            "rent": rentTextField.text!,
            "descriptionn": descriptionTextField.text!
        ])
        
    }
}
