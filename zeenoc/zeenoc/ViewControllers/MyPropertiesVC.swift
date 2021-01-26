//
//  MyPropertiesVC.swift
//  zeenoc
//
//  Created by Helal Chowdhury on 1/25/21.
//

import UIKit
import Firebase

class MyPropertiesVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

    }
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    

}

extension MyPropertiesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "PropertyDetailsVC") as? PropertyDetailsVC

        vc?.address = properties[indexPath.row].address
        vc?.id = properties[indexPath.row].id
        vc?.rent = properties[indexPath.row].rent
        vc?.deadline = properties[indexPath.row].deadline
        vc?.room = properties[indexPath.row].room
        vc?.bath = properties[indexPath.row].bath
        vc?.squareFeet = properties[indexPath.row].squareFoot
        vc?.tenant = properties[indexPath.row].tenantName
        
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return properties.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.tableView.register(UINib(nibName: "MyPropertyCell", bundle: nil), forCellReuseIdentifier: "MyPropertyCell")

        let cell = tableView.dequeueReusableCell(withIdentifier: "MyPropertyCell") as! MyPropertyCell

        let name = properties[indexPath.row].tenantName
        let address = properties[indexPath.row].address
        let room = properties[indexPath.row].room
        let bath = properties[indexPath.row].bath
        let squareFoot = properties[indexPath.row].squareFoot
        let rent = properties[indexPath.row].rent
        
        cell.setProperty(tenantName: name, address: address, rentAmount: rent, room: room, bath: bath, squareFoot: squareFoot)
        return cell
    }
    

}


