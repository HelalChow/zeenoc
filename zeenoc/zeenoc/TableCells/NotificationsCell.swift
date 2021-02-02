//
//  NotificationsCell.swift
//  zeenoc
//
//  Created by Helal Chowdhury on 2/1/21.
//

import UIKit

class NotificationsCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    func setNotification(tenantName: String, address: String){
        nameLabel.text = tenantName
        addressLabel.text = address
    }
    
}
