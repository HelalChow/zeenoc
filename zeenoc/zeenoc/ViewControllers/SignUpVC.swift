//
//  SignUpVC.swift
//  zeenoc
//
//  Created by Helal Chowdhury on 12/17/20.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpVC: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var accountSegmentedControl: UISegmentedControl!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    var accountType = "tenants"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupElements()
    }
    
    func setupElements() {
        errorLabel.alpha = 0
        
        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(lastNameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(signUpButton)
        
    }
    @IBAction func accountChanged(_ sender: Any) {
        switch accountSegmentedControl.selectedSegmentIndex {
        case 0:
            accountType = "tenants"
        case 1:
            accountType = "landlords"
        default:
            break
        }
    }
    
    func validateFields() -> Bool {
        //Check if password is valid
        let cleanPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isPasswordValid(cleanPassword) == false {
            self.showError("Password must contain: 8 characters, a number, special character")
            return true
        }
        
        // Check if all fields are filled in
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            self.showError("Please fill in all fields")
            return true
        }
        
        return false
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        
        let err = validateFields()
        
        if err == false {
            
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
//            let db = Firestore.firestore()
//            let user = Auth.auth().currentUser
//            db.collection(self.accountType).document(user!.uid).setData(["firstName": firstName, "lastName": lastName,"email": email, "accountType": self.accountType, "uid": user?.uid as Any])
//            transitionToHome()


            //Create User
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                if err != nil {
                    self.showError(err!.localizedDescription)
                } else {
                    let db = Firestore.firestore()
                    db.collection(self.accountType).addDocument(data: [
                        "firstName": firstName,
                        "lastName": lastName,
                        "email": email,
                        "accountType": self.accountType,
                        "uid": result!.user.uid
                    ]) { (error) in
                        if error != nil {
                            self.showError(error!.localizedDescription)
                        }
                    }
                    //Transition to Home Screen
                    self.transitionToHome()
                }
            }

        }
    }
    
    func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    

    func transitionToHome() {
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.landlordVC) as? LandlordVC
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
}
