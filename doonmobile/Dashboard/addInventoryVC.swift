//
//  addInventoryVC.swift
//  doonmobile
//
//  Created by Aryan Ahmad on 2020-11-30.
//  Copyright © 2020 Aryan Ahmad. All rights reserved.
//
import UIKit
import Alamofire
import Foundation
import MaterialComponents
import MaterialComponents.MaterialDialogs




class addInventory: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    // Variables to hold lists
    private var contentTypes = [ContentType]();
    private var customers = [Customer]();
    private var tareValues = [TareType]();
    private var productNumbers = [ProductNumber]()
    private var productLocations = [ProductLocation]()
    private var materials = [Material]()
    
    //Variables to hold ID's to send back to server
    private var selectedCustomerId = 0;
    private var selectedCarrierId = 0;
    private var selectedContentTypeId = -1;
    private var selectedMaterialId = -1;
    private var selectedTareValueId = -1;
    private var selectedProductNumberId = -1;
    private var selectedProductLocationId = -1;
    private var selectedEntryDate = "";
    
    
    @IBOutlet weak var materialId: UITextField!
    @IBOutlet weak var customerId: UITextField!
    @IBOutlet weak var contentTypeId: UITextField!
    @IBOutlet weak var netWeight: UITextField!
    @IBOutlet weak var tareValueId: UITextField!
    @IBOutlet weak var grossWeight: UITextField!
    @IBOutlet weak var productNumberId: UITextField!
    @IBOutlet weak var productLocationId: UITextField!
    @IBOutlet weak var unit: UITextField!
    @IBOutlet weak var entryDate: UITextField!
    @IBOutlet weak var submitbutton: MDCButton!
    
    var customerPickerView = UIPickerView()
    var contentTypePickerView = UIPickerView()
    var materialPickerView = UIPickerView()
    var tarePickerView = UIPickerView()
    var productNumberPickerView = UIPickerView()
    var productLocatioinPickerView = UIPickerView()
    var entryDatePickerView = UIDatePicker()
    
    func createDatePicker(){
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //Done Button
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(entryDateDoneButton))
        toolbar.setItems([doneButton], animated: true)
        entryDate.inputAccessoryView = toolbar;
        entryDate.inputView = entryDatePickerView;
        
        entryDatePickerView.datePickerMode = .date
    }
    
    @objc func entryDateDoneButton()
    {
        //formatter
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        entryDate.text =  formatter.string(from: entryDatePickerView.date)
        
        // Format the entry date to what the server needs
        let utcFormatter = DateFormatter()
        utcFormatter.timeZone = TimeZone(identifier: "UTC")
        utcFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        //print("Formatted Date",utcFormatter.string(from: Date()))
        self.selectedEntryDate = utcFormatter.string(from: Date());
        
        self.view.endEditing(true)
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch pickerView.tag {
        case 1:
            return customers.count
        case 2:
            return contentTypes.count
        case 3:
            return tareValues.count
        case 4:
            return productNumbers.count
        case 5:
            return productLocations.count
        case 6:
            return materials.count
        default:
            return 0;
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        switch pickerView.tag {
        case 1:
            return customers[row].name
        case 2:
            return contentTypes[row].description
        case 3:
            return String(tareValues[row].value)
        case 4:
            return productNumbers[row].description
        case 5:
            return productLocations[row].description
        case 6:
            return materials[row].description
        default:
            return "";
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        switch pickerView.tag {
        case 1:
            customerId.text = customers[row].name
            self.selectedCustomerId = customers[row].customerId;
            customerId.resignFirstResponder()
        case 2:
            contentTypeId.text = contentTypes[row].description
            self.selectedContentTypeId = contentTypes[row].contentTypeId;
            contentTypeId.resignFirstResponder()
        case 3:
            tareValueId.text = String(tareValues[row].value)
            self.selectedTareValueId = tareValues[row].tareValueId;
            tareValueId.resignFirstResponder()
        case 4:
            productNumberId.text = String(productNumbers[row].description)
            self.selectedProductNumberId = productNumbers[row].productNumberId;
            productNumberId.resignFirstResponder()
        case 5:
            productLocationId.text = String(productLocations[row].description)
            self.selectedProductLocationId = productLocations[row].productLocationId;
            productLocationId.resignFirstResponder()
        case 6:
            materialId.text = String(materials[row].description)
            self.selectedMaterialId = materials[row].DT_RowId;
            materialId.resignFirstResponder()
        default:
            print("error")
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        materialId.placeholder = "Material"
        materialId.text = ""
        customerId.placeholder = "Customer"
        customerId.text = ""
        contentTypeId.placeholder = "Content Type"
        contentTypeId.text = ""
        netWeight.placeholder = "Net Weight"
        netWeight.text = ""
        tareValueId.placeholder = "Tare Value"
        tareValueId.text = ""
        grossWeight.placeholder = "Gross Weight"
        grossWeight.text = ""
        productNumberId.placeholder = "Product Number"
        productNumberId.text = ""
        productLocationId.placeholder = "Product Location"
        productLocationId.text = ""
        unit.placeholder = "Unit"
        unit.text = ""
        entryDate.placeholder = "Entry Date"
        entryDate.text = ""
        
        //Customer PickerView
        customerId.inputView = customerPickerView
        customerPickerView.delegate = self
        customerPickerView.dataSource = self
        customerPickerView.tag = 1
        
        //ContentType PickerView
        contentTypeId.inputView = contentTypePickerView
        contentTypePickerView.delegate = self
        contentTypePickerView.dataSource = self
        contentTypePickerView.tag = 2
        
        //Tare PickerView
        tareValueId.inputView = tarePickerView
        tarePickerView.delegate = self
        tarePickerView.dataSource = self
        tarePickerView.tag = 3
        
        
        //Product Location PickerView
        productLocationId.inputView = productLocatioinPickerView
        productLocatioinPickerView.delegate = self
        productLocatioinPickerView.dataSource = self
        productLocatioinPickerView.tag = 5
        
        
        //Product Number PickerView
        productNumberId.inputView = productNumberPickerView
        productNumberPickerView.delegate = self
        productNumberPickerView.dataSource = self
        productNumberPickerView.tag = 4
        
        // Material PickerView Setup
        materialId.inputView = materialPickerView
        materialPickerView.delegate = self
        materialPickerView.dataSource = self
        materialPickerView.tag = 6
        
        createDatePicker();
        //Load Reference Data for form from Defaults
        loadRefData();
        
        
    }
    
    fileprivate func showAlert(_ message: String, _ title: String) {
          let alertController = MDCAlertController(title: title, message: message)
          let action = MDCAlertAction(title:"OK") { (action) in print("OK") }
          alertController.addAction(action)
          self.present(alertController, animated:true, completion: nil)
      }
    
    @IBAction func submitbuttonClick(_ sender: Any) {
        var newInventory: Parameters
        
        /*
         newInventory = [
         "materialId": Int(materialId.text!)!,
         "customerId": Int(customerId.text!)!,
         "contentTypeId": Int(contentTypeId.text!)!,
         "netWeight": Int(netWeight.text!)!,
         "tareValueId": Int(tareValueId.text!)!,
         "grossWeight": Int(grossWeight.text!)!,
         "productNumberId": Int(productNumberId.text!)!,
         "productLocationId": Int(productLocationId.text!)!,
         "unit": unit.text!,
         "entryDate": entryDate.text! //check this
         ]
         */
        
        //Get created date and format it to the server request
        let createdDateUTC = DateFormatter()
        createdDateUTC.timeZone = TimeZone(identifier: "UTC")
        createdDateUTC.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        
        newInventory = [
            "materialId": selectedMaterialId,
            "customerId": selectedCustomerId,
            "contentTypeId": selectedContentTypeId,
            "netWeight": Int(netWeight.text!)!,
            "tareValueId": selectedTareValueId,
            "grossWeight": Int(grossWeight.text!)!,
            "productNumberId": selectedProductNumberId,
            "productLocationId": selectedProductLocationId,
            "unit": unit.text!,
            "entryDate": selectedEntryDate,
            "createdDate" : selectedEntryDate
        ]
        
        ApiManager.shared.createNewInventoryItem(myparams: newInventory){
            (result, message) in
            if(result)
            {
                self.dismiss(animated: true, completion: nil)
            }
            else{
                self.showAlert(message, "Entry Error")
            }
        }
        
        
        
    }
    
    func loadRefData()
    {
        // Read/Get Data
        if let data = UserDefaults.standard.data(forKey: "formRefData") {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()
                
                // Decode Reference Data
                let refData = try decoder.decode(FormReferenceData.self, from: data)
                self.contentTypes = refData.contentTypes!;
                self.customers = refData.customers!;
                self.tareValues = refData.tareValues!;
                self.productNumbers = refData.productNumbers!
                self.productLocations = refData.productLocations!
                self.materials = refData.materials!
                
                
            } catch {
                print("Unable to Decode Note (\(error))")
            }
        }
        
    }
    
    
}
