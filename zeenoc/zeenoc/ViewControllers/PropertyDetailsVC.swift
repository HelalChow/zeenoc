//
//  PropertyDetailsVC.swift
//  zeenoc
//
//  Created by Helal Chowdhury on 1/26/21.
//

import UIKit
import Firebase

class PropertyDetailsVC: UIViewController {

    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var rentLabel: UILabel!
    @IBOutlet weak var deadlineLabel: UILabel!
    @IBOutlet weak var roomLabel: UILabel!
    @IBOutlet weak var bathLabel: UILabel!
    @IBOutlet weak var squareFeetLabel: UILabel!
    @IBOutlet weak var tenantLabel: UILabel!
    
    var address = ""
    var id = ""
    var rent = ""
    var deadline = ""
    var room = ""
    var bath = ""
    var squareFeet = ""
    var tenant = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addressLabel.text = address
        idLabel.text = id
        rentLabel.text = rent
        deadlineLabel.text = deadline
        roomLabel.text = room
        bathLabel.text = bath
        squareFeetLabel.text = squareFeet
        tenantLabel.text = tenant
    }
    
    @IBAction func deleteTapped(_ sender: Any) {
        let db = Firestore.firestore()
        let user = Auth.auth().currentUser?.uid
        db.collection("users").document(user!).collection("properties").document(id).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
}
