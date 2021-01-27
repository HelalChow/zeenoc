//
//  LandlordVC.swift
//  zeenoc
//
//  Created by Helal Chowdhury on 12/9/20.
//

import UIKit
import Firebase
import Charts
import TinyConstraints

var properties = [Property]()
var tenantProperties = [Property]()

class LandlordVC: UIViewController {

    @IBOutlet weak var pieChart: PieChartView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var onTimeStepper: UIStepper!
    @IBOutlet weak var missedStepper: UIStepper!
    @IBOutlet weak var lateStepper: UIStepper!
    
    var onTimeDataEntry = PieChartDataEntry(value: 0)
    var missedDataEntry = PieChartDataEntry(value: 0)
    var lateDataEntry = PieChartDataEntry(value: 0)
    
    var numberOfEntries = [PieChartDataEntry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let anonymousFunction = { (propertyList: [Property], tenantPropertyList: [Property]) in
            properties = propertyList
            tenantProperties = tenantPropertyList
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        firebaseCall(completion: anonymousFunction)
        tableView.delegate = self
        tableView.dataSource = self
        
        pieChart.chartDescription?.text = ""
        
        onTimeDataEntry.value = onTimeStepper.value
        onTimeDataEntry.label = "Recieved"
        missedDataEntry.value = missedStepper.value
        missedDataEntry.label = "Missed"
        lateDataEntry.value = lateStepper.value
        lateDataEntry.label = "Late"
        
        numberOfEntries = [onTimeDataEntry, missedDataEntry, lateDataEntry]
        updateChartData()
    }
    
    @IBAction func changeOnTime(_ sender: UIStepper) {
        onTimeDataEntry.value = sender.value
        updateChartData()
    }
    @IBAction func changeMissed(_ sender: UIStepper) {
        missedDataEntry.value = sender.value
        updateChartData()
    }
    @IBAction func changeLate(_ sender: UIStepper) {
        lateDataEntry.value = sender.value
        updateChartData()
    }
    
    func updateChartData() {
        let chartDataSet = PieChartDataSet(entries: numberOfEntries, label: nil)
        let chartData = PieChartData(dataSet: chartDataSet)
        
        let colors = [UIColor(named: "onTimeColor"), UIColor(named: "missedColor"), UIColor(named: "lateColor")]
        chartDataSet.colors = colors as! [NSUIColor]
        
        pieChart.data = chartData
    }
 
    func firebaseCall(completion:@escaping([Property], [Property])->()) {
        var currProperties = [Property]()
        var currTenantProperties = [Property]()
        let uid = Auth.auth().currentUser?.uid
        let db = Firestore.firestore()
//        db.collection("users").document(uid!).collection("properties").getDocuments() { (snap, err) in
//            if err != nil {
//                return
//            }
//            for property in snap!.documents {
//                let id = property.documentID
//                let name = property.get("tenantName") as? String
//                let address = property.get("address") as! String
//                let deadline = property.get("deadline") as! String
//                let rent = property.get("rent") as! String
//                let room = property.get("room") as! String
//                let bath = property.get("bath") as! String
//                let squareFoot = property.get("squareFoot") as! String
//
//                currProperties.append(Property(id: id, tenantName: name ?? "N/A", address: address, deadline: "12/" + deadline + "/2021", rent: "$" + String(rent), room: room + " bds", bath: bath + " ba", squareFoot: squareFoot + " sqft"))
//
//                if (name != nil) {
//                    currTenantProperties.append(Property(id: id, tenantName: name ?? "N/A", address: address, deadline: "12/" + deadline + "/2021", rent: "$" + String(rent), room: room + " bds", bath: bath + " ba", squareFoot: squareFoot + " sqft"))
//                }
//
//            }
//            properties = currProperties
//            tenantProperties = currTenantProperties
//            DispatchQueue.main.async {
//                completion(properties, tenantProperties)
//            }
//        }
        
        db.collection("users").document(uid!).collection("properties").addSnapshotListener { (snap, err) in
            if err != nil {
                return
            }
            for property in snap!.documents {
                let id = property.documentID
                let name = property.get("tenantName") as? String
                let address = property.get("address") as! String
                let deadline = property.get("deadline") as! String
                let rent = property.get("rent") as! String
                let room = property.get("room") as! String
                let bath = property.get("bath") as! String
                let squareFoot = property.get("squareFoot") as! String

                currProperties.append(Property(id: id, tenantName: name ?? "N/A", address: address, deadline: "12/" + deadline + "/2021", rent: "$" + String(rent), room: room + " bds", bath: bath + " ba", squareFoot: squareFoot + " sqft"))

                if (name != nil) {
                    currTenantProperties.append(Property(id: id, tenantName: name ?? "N/A", address: address, deadline: "12/" + deadline + "/2021", rent: "$" + String(rent), room: room + " bds", bath: bath + " ba", squareFoot: squareFoot + " sqft"))
                }

            }
            properties = currProperties
            tenantProperties = currTenantProperties
            DispatchQueue.main.async {
                completion(properties, tenantProperties)
            }
        }
    }
    
    @IBAction func logOutTapped(_ sender: Any) {
        do {
            print("tapped")
            try Auth.auth().signOut()
        }
        catch {
            print("there was a problem")
        }
        let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.startVC) as? StartVC
        self.view.window?.rootViewController = homeViewController
        self.view.window?.makeKeyAndVisible()
        
    }
    
    @IBAction func myUnwindAction(unwindSegue: UIStoryboardSegue){
        let anonymousFunction = { (propertyList: [Property], tenantPropertyList: [Property]) in
            properties = propertyList
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
//        firebaseCall(completion: anonymousFunction)
    }

}

extension LandlordVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! PropertyCell
        
    }
}

extension LandlordVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tenantProperties.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.tableView.register(UINib(nibName: "PropertyCell", bundle: nil), forCellReuseIdentifier: "PropertyCell")

        let cell = tableView.dequeueReusableCell(withIdentifier: "PropertyCell") as! PropertyCell

        let name = tenantProperties[indexPath.row].tenantName
        let address = tenantProperties[indexPath.row].address
        let deadline = tenantProperties[indexPath.row].deadline
        let rent = tenantProperties[indexPath.row].rent
        
        cell.setProperty(tenantName: name, address: address, rentAmount: rent, deadline: deadline)
        return cell
    }
}
