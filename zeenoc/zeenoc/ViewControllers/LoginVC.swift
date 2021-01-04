//
//  LoginVC.swift
//  zeenoc
//
//  Created by Helal Chowdhury on 12/17/20.
//

import UIKit
import FirebaseAuth
import Firebase

class LoginVC: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupElements()
    }
    
    func setupElements() {
        errorLabel.alpha = 0
        
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(loginButton)
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
            } else {
//                let db = Firestore.firestore()
//                let user = Auth.auth().currentUser
//
//                let docRef = db.collection("landlords").document(user!.uid)
//                docRef.getDocument { (document, error) in
//                    if document!.exists {
//                        let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.landlordVC) as? LandlordVC
//                        self.view.window?.rootViewController = homeViewController
//                        self.view.window?.makeKeyAndVisible()
//
//                      } else {
//                        let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.tenantVC) as? TenantVC
//                        self.view.window?.rootViewController = homeViewController
//                        self.view.window?.makeKeyAndVisible()
//                      }
//                }
                let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.landlordVC) as? LandlordVC
                self.view.window?.rootViewController = homeViewController
                self.view.window?.makeKeyAndVisible()

            }
        }
        
    }

    
    
}
