//
//  LandlordVC.swift
//  zeenoc
//
//  Created by Helal Chowdhury on 12/9/20.
//

import UIKit
import Firebase

var properties = [Property]()

class LandlordVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let house1 = Property(id: "12345", tenantName: "Amy White", address: "9419 Linden Blvd Ozone Park NY 11417", deadline: "12/15/2020", rent: "$2000")
    let house2 = Property(id: "6789", tenantName: "Samantha Brown", address: "8218 9th Ave Elmont NY 11635", deadline: "12/19/2020", rent: "$1800")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firebaseCall()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func firebaseCall() {
        let uid = Auth.auth().currentUser?.uid
        let db = Firestore.firestore()
        db.collection("landlords").document("qgzC3W8vCEIPt7hfcHsQ").collection("properties").getDocuments() { (snap, err) in
//            if err != nil {
//                return
//            }
            if let err = err {
                print("error getting documents")
            }
            else{
                for property in snap!.documents {
                    print("fdeferf")
                    let id = property.documentID
                    let name = property.get("tenantName") as! String
                    let address = property.get("address") as! String
                    let deadline = property.get("deadline") as! String
                    let rent = property.get("tenantName") as! String
                    
                    properties.append(Property(id: id, tenantName: name, address: address, deadline: "12/" + deadline + "/2020", rent: "$" + rent))
                }
            }
        }
    }
    
}
extension LandlordVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! PropertyCell
        
    }
}

extension LandlordVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return properties.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.tableView.register(UINib(nibName: "PropertyCell", bundle: nil), forCellReuseIdentifier: "PropertyCell")

        let cell = tableView.dequeueReusableCell(withIdentifier: "PropertyCell") as! PropertyCell

        let name = properties[indexPath.row].tenantName
        let address = properties[indexPath.row].address
        let deadline = properties[indexPath.row].deadline
        let rent = properties[indexPath.row].rent
        cell.setProperty(tenantName: name, address: address, rentAmount: rent, deadline: deadline)
        return cell
    }
}
