//
//  LandlordVC.swift
//  zeenoc
//
//  Created by Helal Chowdhury on 12/9/20.
//

import UIKit

class LandlordVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var properties = [Property]()
    let house1 = Property(tenantName: "Amy White", address: "9419 Linden Blvd Ozone Park NY 11417", deadline: "12/15/2020", rent: "$2000")
    let house2 = Property(tenantName: "Samantha Brown", address: "8218 9th Ave Elmont NY 11635", deadline: "12/19/2020", rent: "$1800")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        properties.append(house1)
        properties.append(house2)
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
