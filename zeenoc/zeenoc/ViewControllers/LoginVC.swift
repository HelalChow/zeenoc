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
                let db = Firestore.firestore()
                let uid = Auth.auth().currentUser?.uid
                print(uid)
                let docRef = db.collection("users").document(uid!)
                    docRef.getDocument(source: .cache) { (document, error) in
                        if let document = document {
                            let type = document.get("accountType")
                            if (type as! String == "landlords"){
                                self.performSegue(withIdentifier: "LandlordTabBarController", sender: nil)
                            }
                            else if (type as! String == "tenants"){
                                let paired = document.get("paired")
                 
                                if paired as! String == "false"{
                                    self.performSegue(withIdentifier: "ConnectPropertyVC", sender: nil)
                                }
                                else if paired as! String == "true" {
                                    self.performSegue(withIdentifier: "TenantTabBarController", sender: nil)
                                }
                                
                            }
                        } else {
                            print("Document does not exist in cache")
                        }
                    }
            }
        }
        
        
    }

}
