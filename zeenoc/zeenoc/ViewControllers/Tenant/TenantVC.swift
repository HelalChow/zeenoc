//
//  TenantVC.swift
//  zeenoc
//
//  Created by Helal Chowdhury on 1/4/21.
//

import UIKit
import Firebase
import Charts

var payments = [Payment]()

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
        payments.removeAll()
        
        let anonymousFunction = { (paymentList: [Payment]) in
            payments = paymentList
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        firebaseCall(completion: anonymousFunction)
 
        pieChartView.chartDescription?.text = ""
        onTimeDataEntry.value = 20
        onTimeDataEntry.label = "Sent"
        missedDataEntry.value = 10
        missedDataEntry.label = "Missed"
        lateDataEntry.value = 5
        lateDataEntry.label = "Late"
        numberOfEntries = [onTimeDataEntry, missedDataEntry, lateDataEntry]
        updateChartData()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func firebaseCall(completion:@escaping([Payment])->()) {
        let uid = Auth.auth().currentUser?.uid
        let db = Firestore.firestore()

        db.collection("users").document(uid!).collection("payments").addSnapshotListener { (snap, err) in
            if err != nil {
                return
            }
            for payment in snap!.documentChanges {
                if payment.type == .added {
                    let uid = payment.document.documentID
                    let deadlineDate = payment.document.get("deadline") as! String
                    let rentAmount = payment.document.get("rent") as! String
                    let statusShow = payment.document.get("status") as! String
                    let tenant = payment.document.get("tenantID") as! String
                    let landlord = payment.document.get("landlordID") as! String
                    let property = payment.document.get("propertyID") as! String
                    
                    payments.append(Payment(id: uid, deadline: "03/" + deadlineDate + "/2021", rent: "$" + rentAmount, status: "Status: " + statusShow, tenantID: tenant, landloardID: landlord, propertyID: property))

                }
                if payment.type == .removed {
                    let id = payment.document.documentID
                    for i in 0..<payments.count {
                        if payments[i].id == id {
                            payments.remove(at: i)
//                            if properties.isEmpty {
//                                self.noData = true
//                            }
                            return
                        }
                    }
                }

            }
            DispatchQueue.main.async {
                completion(payments)
            }
        }
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

extension TenantVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        payments.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.tableView.register(UINib(nibName: "PaymentsCell", bundle: nil), forCellReuseIdentifier: "PaymentsCell")

        let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentsCell") as! PaymentsCell

        let deadline = payments[indexPath.row].deadline
        let rent = payments[indexPath.row].rent
        let status = payments[indexPath.row].status


        cell.setPaymentCell(deadline: deadline, rent: rent, status: status)
        return cell
    }


}
