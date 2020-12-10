//
//  PropertyCell.swift
//  zeenoc
//
//  Created by Helal Chowdhury on 12/9/20.
//

import UIKit

class PropertyCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var rentLabel: UILabel!
    @IBOutlet weak var deadlineLabel: UILabel!
    
    
    func setProperty(tenantName: String, address: String, rentAmount: String, deadline: String){
        nameLabel.text = tenantName
        addressLabel.text = address
        rentLabel.text = rentAmount
        deadlineLabel.text = deadline
    }
    
}
