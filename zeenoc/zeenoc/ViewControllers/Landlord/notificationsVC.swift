//
//  notificationsVC.swift
//  zeenoc
//
//  Created by Helal Chowdhury on 2/1/21.
//

import UIKit
import Firebase

var requests = [Request]()

class notificationsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requests.removeAll()
        
        let anonymousFunction = { (requestList: [Request]) in
            requests = requestList
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        firebaseCall(completion: anonymousFunction)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func firebaseCall(completion:@escaping([Request])->()) {
        let uid = Auth.auth().currentUser?.uid
        let db = Firestore.firestore()
        
        db.collection("users").document(uid!).collection("requests").addSnapshotListener { (snap, err) in
            if err != nil {
                return
            }
            for request in snap!.documentChanges {
                if request.type == .added {
                    let id = request.document.documentID
                    let name = request.document.get("tenantName")
                    let address = request.document.get("address")
                    let tenantID = request.document.get("tenantID") as! String
                    let propertyID = request.document.get("propertyID") as! String

                    requests.append(Request(id: id, tenantName: name as? String ?? "Name not found", address: address as? String ?? "Address not founf", tenantID: tenantID, propertyID: propertyID))

                }
                if request.type == .removed {
                    let id = request.document.documentID
                    for i in 0..<requests.count {
                        if requests[i].id == id {
                            requests.remove(at: i)
//                            if properties.isEmpty {
//                                self.noData = true
//                            }
                            return
                        }
                    }
                }

            }
            DispatchQueue.main.async {
                completion(requests)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let id = requests[indexPath.row].id
        let remove = UIContextualAction(style: .normal, title: "Decline") { (action, view, nil) in
//            requests.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .left)
           }
        
        remove.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        removeRequest(id: id)
        
        let config = UISwipeActionsConfiguration(actions: [remove])
        config.performsFirstActionWithFullSwipe = true
        return config
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let id = requests[indexPath.row].id
        let tenant = requests[indexPath.row].tenantID
        let property = requests[indexPath.row].propertyID
        let tenantName = requests[indexPath.row].tenantName
        
        let remove = UIContextualAction(style: .normal, title: "Accept") { (action, view, nil) in
//            requests.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .right)
           }
        removeRequest(id: id)
        makePairedTrue(tentantID: tenant, propertyID: property)
        addNameToProperty(tentantID: tenant, tenantName: tenantName, propertyID: property)
        addPaymentToTenant(tentantID: tenant, propertyID: property)
        
        remove.backgroundColor = .green
        
        let config = UISwipeActionsConfiguration(actions: [remove])
        config.performsFirstActionWithFullSwipe = true
        
        return config
    }
    
    func removeRequest(id : String) {
        let db = Firestore.firestore()
        let user = Auth.auth().currentUser?.uid
        db.collection("users").document(user!).collection("requests").document(id).delete() { err in
            if let err = err {
                print("Error removing request: \(err)")
            } else {
                print("Request Document successfully removed!")
            }
        }
    }
    
    func makePairedTrue(tentantID : String, propertyID: String){
        let db = Firestore.firestore()
        db.collection("users").document(tentantID).setData(["paired":"true", "properyID": propertyID], merge: true)
    }
    
    func addNameToProperty(tentantID : String, tenantName : String, propertyID: String){
        let db = Firestore.firestore()
        let user = Auth.auth().currentUser?.uid
        db.collection("users").document(user!).collection("properties").document(propertyID).setData(["tenantName":tenantName, "tenantID": tentantID], merge: true)
    }
    
    func addPaymentToTenant(tentantID : String, propertyID: String){
        let db = Firestore.firestore()
        let user = Auth.auth().currentUser?.uid
        db.collection("users").document(user!).collection("properties").document(propertyID).getDocument { (doc, err) in
            if let doc = doc, doc.exists {
                let deadline = doc.get("deadline") as! String
                let rent = doc.get("rent") as! String
                db.collection("users").document(tentantID).collection("payments").addDocument(data: [
                    "deadline": deadline,
                    "rent": rent,
                    "status": "Pending",
                    "tenantID": tentantID,
                    "landlordID": user!,
                    "propertyID": propertyID
                ])

            } else {
                print("property doesnt exist")
            }
        }
        
    }
 
}

extension notificationsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return requests.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.tableView.register(UINib(nibName: "NotificationsCell", bundle: nil), forCellReuseIdentifier: "NotificationsCell")

        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationsCell") as! NotificationsCell

        let name = requests[indexPath.row].tenantName
        let address = requests[indexPath.row].address


        cell.setNotification(tenantName: name, address: address)
        return cell
    }

}
