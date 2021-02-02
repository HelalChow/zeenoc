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
                    let name = request.document.get("tenantName") as! String
                    let address = request.document.get("address")
                    print(name)
                    print(address)

                    requests.append(Request(id: id, tenantName: name, address: address as? String ?? "not working"))

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
