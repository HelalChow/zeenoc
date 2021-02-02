//
//  ConnectPropertyVC.swift
//  zeenoc
//
//  Created by Helal Chowdhury on 1/30/21.
//

import UIKit
import Firebase

class ConnectPropertyVC: UIViewController {

    @IBOutlet weak var properyIDTextField: UITextField!
    @IBOutlet weak var sendRequestButton: UIButton!
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Utilities.styleTextField(properyIDTextField)
        Utilities.styleFilledButton(sendRequestButton)
    }
    
    @IBAction func sendRequestTapped(_ sender: Any) {
        let db = Firestore.firestore()
        let uid = Auth.auth().currentUser?.uid
        let docRef = db.collection("users").document(uid!)
        docRef.getDocument{ (doc, err) in
            if let doc = doc, doc.exists {
                let firstName = doc.get("firstName") as! String
                let lastName = doc.get("lastName") as! String
                let tenantName = firstName + " " + lastName
                db.collection("properties").document(self.properyIDTextField.text!).getDocument { (document, error) in
                        if let document = document, document.exists {
                            let landlord = document.get("landlord") as! String
                            let address = document.get("address") as! String
                            db.collection("users").document(landlord).collection("requests").addDocument(data: [
                                "tenantID" : uid!,
                                "propertyID" : self.properyIDTextField.text!,
                                "address" : address,
                                "tenantName" : tenantName
                            ])
                            self.errorMessageLabel.text = "Waiting for landlord to approve request. Please log out and log back in once approved"
                            self.errorMessageLabel.textColor = .blue
                            self.errorMessageLabel.alpha = 1
                        } else {
                            self.errorMessageLabel.text = "Property not found"
                            self.errorMessageLabel.alpha = 1
                        }
                    }
                } else {
                    print("User document does not exist")
                }
            
        }
        
        
        
        

     
    }
    
    
    
    
    
    @IBAction func logOutTapped(_ sender: Any) {
        do {
            print("tapped")
            try Auth.auth().signOut()
        }
        catch {
            print("thre was a problem")
        }
        let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.startVC) as? StartVC
        self.view.window?.rootViewController = homeViewController
        self.view.window?.makeKeyAndVisible()
    }
    

}
