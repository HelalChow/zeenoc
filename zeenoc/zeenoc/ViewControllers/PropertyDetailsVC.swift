//
//  PropertyDetailsVC.swift
//  zeenoc
//
//  Created by Helal Chowdhury on 1/26/21.
//

import UIKit

class PropertyDetailsVC: UIViewController {

    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var rentLabel: UILabel!
    @IBOutlet weak var deadlineLabel: UILabel!
    @IBOutlet weak var roomLabel: UILabel!
    @IBOutlet weak var bathLabel: UILabel!
    @IBOutlet weak var squareFeetLabel: UILabel!
    @IBOutlet weak var tenantLabel: UILabel!
    
    var address = ""
    var id = ""
    var rent = ""
    var deadline = ""
    var room = ""
    var bath = ""
    var squareFeet = ""
    var tenant = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addressLabel.text = address
        idLabel.text = id
        rentLabel.text = rent
        deadlineLabel.text = deadline
        roomLabel.text = room
        bathLabel.text = bath
        squareFeetLabel.text = squareFeet
        tenantLabel.text = tenant
    }
    


}
