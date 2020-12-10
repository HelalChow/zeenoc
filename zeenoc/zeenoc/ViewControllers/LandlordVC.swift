//
//  LandlordVC.swift
//  zeenoc
//
//  Created by Helal Chowdhury on 12/9/20.
//

import UIKit

class LandlordVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var Properties : [
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}
extension LandlordVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! PropertyCell
 
    }
}

extension LandlordVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.tableView.register(UINib(nibName: "PropertyCell", bundle: nil), forCellReuseIdentifier: "PropertyCell")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PropertyCell") as! PropertyCell
        
        let name = array[0].data[indexPath.row].transliteration
        let translation = array[0].data[indexPath.row].en.meaning
        let arabic = array[0].data[indexPath.row].name
        cell.setCell(name: name, translation: translation, arabic: arabic, num: String(indexPath.row + 1) + ".")
        
        return cell
    }
}
