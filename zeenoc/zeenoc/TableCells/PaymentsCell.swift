//
//  PaymentsCell.swift
//  zeenoc
//
//  Created by Helal Chowdhury on 2/6/21.
//

import UIKit

class PaymentsCell: UITableViewCell {

    @IBOutlet weak var deadlineLabel: UILabel!
    @IBOutlet weak var rentLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    func setPaymentCell(deadline: String, rent: String, status: String){
        deadlineLabel.text = deadline
        rentLabel.text = rent
        statusLabel.text = status
    }
    
}
