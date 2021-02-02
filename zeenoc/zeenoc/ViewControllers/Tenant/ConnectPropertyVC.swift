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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Utilities.styleTextField(properyIDTextField)
        Utilities.styleFilledButton(sendRequestButton)
    }
    
    @IBAction func sendRequestTapped(_ sender: Any) {
        let db = Firestore.firestore()
        let uid = Auth.auth().currentUser?.uid
        db.collection("properties").document(properyIDTextField.text!).getDocument { (document, error) in
            if let document = document, document.exists {
                let landlord = document.get("landlord") as! String
                db.collection("users").document(landlord).collection("requests").addDocument(data: [
                    "tenant" : uid!,
                    "property" : self.properyIDTextField.text!,
                ])
            } else {
                print(self.properyIDTextField.text!)
                print("document not found")
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
