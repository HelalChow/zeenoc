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
