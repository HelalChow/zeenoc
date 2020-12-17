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
        let anonymousFunction = { (propertyList: [Property]) in
            properties = propertyList
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        firebaseCall(completion: anonymousFunction)
        tableView.delegate = self
        tableView.dataSource = self
        
        pieChart.chartDescription?.text = ""
        
        onTimeDataEntry.value = onTimeStepper.value
        onTimeDataEntry.label = "On Time"
        missedDataEntry.value = missedStepper.value
        missedDataEntry.label = "Missed"
        lateDataEntry.value = lateStepper.value
        lateDataEntry.label = "Late"
        
        numberOfEntries = [onTimeDataEntry, missedDataEntry, lateDataEntry]
        updateChartData()
    }
    
    @IBAction func changeOnTime(_ sender: Any) {
    }
    @IBAction func changeMissed(_ sender: Any) {
    }
    @IBAction func changeLate(_ sender: Any) {
    }
    
    func updateChartData() {
        let chartDataSet = PieChartDataSet(entries: numberOfEntries, label: nil)
        let chartData = PieChartData(dataSet: chartDataSet)
        
        let colors = [UIColor(named: "onTimeColor"), UIColor(named: "missedColor"), UIColor(named: "lateColor")]
        chartDataSet.colors = colors as! [NSUIColor]
        
        pieChart.data = chartData
    }
    
    
    
    
    func firebaseCall(completion:@escaping([Property])->()) {
        let uid = Auth.auth().currentUser?.uid
        let db = Firestore.firestore()
        db.collection("landlords").document("qgzC3W8vCEIPt7hfcHsQ").collection("properties").getDocuments() { (snap, err) in
            if err != nil {
                return
            }
            for property in snap!.documents {
                let id = property.documentID
                let name = property.get("tenantName") as! String
                let address = property.get("address") as! String
                let deadline = property.get("deadline") as! String
                let rent = property.get("rent") as! Int

                properties.append(Property(id: id, tenantName: name, address: address, deadline: "12/" + deadline + "/2020", rent: "$" + String(rent)))
            }
            print(properties)
            DispatchQueue.main.async {
                completion(properties)
            }
        }
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
