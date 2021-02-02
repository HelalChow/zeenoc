//
//  notificationsVC.swift
//  zeenoc
//
//  Created by Helal Chowdhury on 2/1/21.
//

import UIKit
var requests = [Request]()

class notificationsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
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
