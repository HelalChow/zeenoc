//
//  TenantVC.swift
//  zeenoc
//
//  Created by Helal Chowdhury on 1/4/21.
//

import UIKit
import Firebase

class TenantVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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
