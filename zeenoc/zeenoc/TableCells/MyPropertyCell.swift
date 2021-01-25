//
//  MyPropertyCell.swift
//  zeenoc
//
//  Created by Helal Chowdhury on 1/25/21.
//

import UIKit

class MyPropertyCell: UITableViewCell {
    
    @IBOutlet weak var tenantLabel: UILabel!
    @IBOutlet weak var roomLabel: UILabel!
    @IBOutlet weak var bathLabel: UILabel!
    @IBOutlet weak var squareFootLabel: UILabel!
    @IBOutlet weak var rentLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    
    func setProperty(tenantName: String, address: String, rentAmount: String, room: String, bath: String, squareFoot: String){
        tenantLabel.text = tenantName
        roomLabel.text = room
        bathLabel.text = bath
        squareFootLabel.text = squareFoot
        rentLabel.text = rentAmount
        addressLabel.text = address
    }
    
}
