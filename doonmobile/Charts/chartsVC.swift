//
//  chartsVC.swift
//  doonmobile
//
//  Created by Aryan Ahmad on 2020-09-21.
//  Copyright © 2020 Aryan Ahmad. All rights reserved.
//

import Foundation
import Charts
import UIKit

class chartsVC: UIViewController, UITableViewDelegate, UITableViewDataSource{

    
    
    @IBOutlet weak var incomingTable: UITableView!
    @IBOutlet weak var barCV: BarChartView!
    var months: [String]!
    override func viewDidLoad() {
        super.viewDidLoad()

        getInventoryByItemGraphData();
        
        incomingTable.delegate = self
        incomingTable.dataSource = self
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isInventory{
            return inventoryReturn!.items.count
        }
        else if isIncoming{
            return incomingReturn!.shipments.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY, MMM d, HH:mm:ss"
        var formattedDate = dateFormatter.string(from: inventoryReturn!.items[indexPath.row].createdDate)
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        if isInventory{
            cell.textLabel?.text = inventoryReturn!.items[indexPath.row].customerName! + " (" + formattedDate + ")"
        }
        else if isIncoming{
            //Add error checking for if Incoming is empty
            cell.textLabel?.text = incomingReturn!.shipments[indexPath.row].customerName + " (" + formattedDate + ")"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailsStoryboard", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? detailsVC{
            destination.inventory = inventoryReturn!.items[incomingTable.indexPathForSelectedRow!.row]
        }
    }
    
    
    func setChart(dataPoints: [String], values: [Double], title: String) {

        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<dataPoints.count {
          let dataEntry = BarChartDataEntry(x: Double(i), y: Double(values[i]))
          dataEntries.append(dataEntry)
        }
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: title)
        let chartData = BarChartData(dataSet: chartDataSet)
        barCV.data = chartData
        
    }
    
    func getInventoryByItemGraphData()
    {
        ApiManager.shared.callDashboardInventoryByItemGraphData(){ (graphData) in
            if graphData != nil {
                
                // Put API response into an Array as expected by the chart function.
                var itemDescriptionArray:[String] = []
                var weightArray : [Double] = [];
                for t in graphData!.data {
                    itemDescriptionArray.append(t.itemDescription)
                    weightArray.append(Double(t.totalWeightLbs))
                }
                //Call chart function with the expected inputs
                self.setChart(dataPoints: itemDescriptionArray, values: weightArray, title: "Inventory By Item")
                print("CALL SUCCESSFULL TO INVENTORY BY ITEM GRAPH DATA.")
            }
        }
    }

    
}
