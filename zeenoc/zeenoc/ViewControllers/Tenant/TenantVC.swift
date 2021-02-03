//
//  TenantVC.swift
//  zeenoc
//
//  Created by Helal Chowdhury on 1/4/21.
//

import UIKit
import Firebase
import Charts

class TenantVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var payButton: UIButton!
    
    var onTimeDataEntry = PieChartDataEntry(value: 0)
    var missedDataEntry = PieChartDataEntry(value: 0)
    var lateDataEntry = PieChartDataEntry(value: 0)
    var numberOfEntries = [PieChartDataEntry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        pieChartView.chartDescription?.text = ""
        onTimeDataEntry.value = 20
        onTimeDataEntry.label = "Sent"
        missedDataEntry.value = 10
        missedDataEntry.label = "Missed"
        lateDataEntry.value = 5
        lateDataEntry.label = "Late"
        numberOfEntries = [onTimeDataEntry, missedDataEntry, lateDataEntry]
        updateChartData()
    }
    
    func updateChartData() {
        let chartDataSet = PieChartDataSet(entries: numberOfEntries, label: nil)
        let chartData = PieChartData(dataSet: chartDataSet)
        
        let colors = [UIColor(named: "onTimeColor"), UIColor(named: "missedColor"), UIColor(named: "lateColor")]
        chartDataSet.colors = colors as! [NSUIColor]
        
        pieChartView.data = chartData
    }
    
    @IBAction func logOutTapped(_ sender: Any) {
        do {
            print("tapped")
            try Auth.auth().signOut()
        }
        catch {
            print("thre was a problem")
        }
        let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.startVC) as? StartVC
        self.view.window?.rootViewController = homeViewController
        self.view.window?.makeKeyAndVisible()
    }
    
    @IBAction func payTapped(_ sender: Any) {
    }
    
}
