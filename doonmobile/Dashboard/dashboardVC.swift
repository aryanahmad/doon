//
//  dashboardVC.swift
//  doonmobile
//
//  Created by Aryan Ahmad on 2020-09-08.
//  Copyright © 2020 Aryan Ahmad. All rights reserved.
//

import Foundation
import UIKit
import MaterialComponents.MaterialCards
import MaterialComponents.MaterialActionSheet
import Alamofire
var inventoryReturn:InventoryItemListResponse?
var incomingReturn:IncomingShipmentList?
var isInventory = false
var isIncoming = false
class dashboardVC: UIViewController{
    @IBOutlet weak var inventoryCard: MDCCard!
    @IBOutlet weak var inventoryLabel: UILabel!
    
    @IBOutlet weak var outgoingCard: MDCCard!
    @IBOutlet weak var outgoingLabel: UILabel!
    
    @IBOutlet weak var incomingCard: MDCCard!
    @IBOutlet weak var incomingLabel: UILabel!
    
    @IBOutlet weak var usersCard: MDCCard!
    @IBOutlet weak var usersLabel: UILabel!
    
    @IBOutlet weak var addButton: MDCFloatingButton!
    @IBOutlet weak var setttingsButton: UIButton!
    @IBOutlet weak var labeldemo: UILabel!
    @IBOutlet var view1: UIView!
    let actionSheet = MDCActionSheetController(title: "Action Sheet",
    message: "Secondary line text")
    
    override func viewDidLoad(){
        super.viewDidLoad()

        
        inventoryCard.cornerRadius = 15
        outgoingCard.cornerRadius = 15
        incomingCard.cornerRadius = 15
        usersCard.cornerRadius = 15
        getReferenceData();
        loadFormReferenceData();
    }
    
    
    @IBAction func addButtonClick(_ sender: Any) {
        //open other storyboard
        
        let actionSheet = MDCActionSheetController(title: "Add", message: "What would you like to add?")
        let actionOne = MDCActionSheetAction(title: "Inventory", image: nil, handler: { (action) in
            self.goToAddController()
        })
        let actionTwo = MDCActionSheetAction(title: "Material", image: nil, handler: { (action) in
            self.goToAddController()
        })
        let actionThree = MDCActionSheetAction(title: "Product", image: nil, handler: { (action) in
            self.goToAddController()
        })
        let actionFour = MDCActionSheetAction(title: "Users", image: nil, handler: { (action) in
            self.goToAddController()
        })
        actionSheet.addAction(actionOne)
        actionSheet.addAction(actionTwo)
        actionSheet.addAction(actionThree)
        actionSheet.addAction(actionFour)
        present(actionSheet, animated: true, completion: nil)
        
        //navigationController.modalPresentationStyle = .fullScreen
        
    }
    func goToAddController(){
        let addController = UIStoryboard(name: "addInventory", bundle: nil).instantiateViewController(withIdentifier: "addInventoryStoryboard") as! addInventory
        //addController.modalPresentationStyle = .fullScreen;
        self.present(addController, animated: true, completion: nil)
    }
    
    @IBAction func inventoryClick(_ sender: Any) {
        isInventory = true
        isIncoming = false
        chartOpener()
    }
    
    @IBAction func outgoingClick(_ sender: Any) {
        chartOpener()
    }
    
    @IBAction func incomingClick(_ sender: Any) {
        isInventory = false
        isIncoming = true
        chartOpener()
    }
    
    @IBAction func usersClick(_ sender: Any) {
        chartOpener()
    }
    
    func chartOpener(){
        let chartController = UIStoryboard(name: "chartsSB", bundle: nil).instantiateViewController(withIdentifier: "chartsViewController") as! chartsVC
        self.present(chartController, animated: true, completion: nil)
    }
    
    func logoutAction()
    {
        print("LOGOUT ACTION GOES HERE ");
    }
    
    @IBAction func setingsButtonClick(_ sender: Any) {
        let actionSheet = MDCActionSheetController(title: "Settings", message: "Adjust your settings here")
        let actionOne = MDCActionSheetAction(title: "Change Password", image: UIImage(named: "Home"))
        let actionTwo = MDCActionSheetAction(title: "Terms & Conditions", image: UIImage(named: "Email"))
        let actionThree = MDCActionSheetAction(title: "Logout", image: UIImage(named: "logout"), handler: { (action) in
            self.logoutAction()
        })
        
        actionSheet.addAction(actionOne)
        actionSheet.addAction(actionTwo)
        actionSheet.addAction(actionThree)
        present(actionSheet, animated: true, completion: nil)
    }
    func getReferenceData(){
        
        ApiManager.shared.callDashboardAPI{ (dashboardResp) in
            if dashboardResp != nil {
                self.incomingLabel.text = String(dashboardResp!.incomingShipmentCount)
                self.usersLabel.text = String(dashboardResp!.usersCount)
                self.outgoingLabel.text = String(dashboardResp!.outgoingShipmentCount)
                self.inventoryLabel.text = String(dashboardResp!.inventoryCount)
                print("CALL SUCCESSFULL TO DASHBOARD.")
            }
        }
        
        // Use this as a sample to call the list and return it in the inventoryListReturn
        ApiManager.shared.callInventoryItemList{ (inventoryListReturn) in
             if inventoryListReturn != nil {
                print("CALL SUCCESSFULL TO INVENTORY ITEM LIST.")
                inventoryReturn = inventoryListReturn
                
             }
         }
        
        // Use this as a sample to call the Incoming shipment list
        ApiManager.shared.callIncomingShipmentList{ (incomingShipmentList) in
            if incomingShipmentList != nil {
               print("CALL SUCCESSFULL TO INCOMING SHIPMENT LIST.")
                incomingReturn = incomingShipmentList
               
            }
        }
        
        
    }
    
    
    func loadFormReferenceData(){
        
        
        ApiManager.shared.callGetFormReferenceData{ (formDataReference) in
            if formDataReference != nil {
                
                do {
                    
                    // Create JSON Encoder
                    let encoder = JSONEncoder()

                    // Encode Note
                    let data = try encoder.encode(formDataReference)

                    // Write/Set Data
                    UserDefaults.standard.set(data, forKey: "formRefData")
                    
                } catch {
                    print("Unable to Encode Form Reference Data (\(error))")
                }
                print("CALL TO GET FORM REF DATA SUCCESS")
            }
            
        }

    }
    
}
