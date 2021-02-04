//
//  detailsVC.swift
//  doonmobile
//
//  Created by Aryan Ahmad on 2021-01-11.
//  Copyright © 2021 Aryan Ahmad. All rights reserved.
//

import Foundation
import Charts
import UIKit

class detailsVC: UIViewController{
//ID is detailsStoryBoard
//Make sure to implement null thing 
    
    @IBOutlet weak var inventoryid: UILabel!
    @IBOutlet weak var itemnum: UILabel!
    @IBOutlet weak var custname: UILabel!
    @IBOutlet weak var custid: UILabel!
    @IBOutlet weak var matdesc: UILabel!
    @IBOutlet weak var matid: UILabel!
    @IBOutlet weak var del: UILabel!
    @IBOutlet weak var created: UILabel!
    @IBOutlet weak var contenttype: UILabel!
    @IBOutlet weak var contentid: UILabel!
    @IBOutlet weak var entrydate: UILabel!
    @IBOutlet weak var tareid: UILabel!
    @IBOutlet weak var netweight: UILabel!
    @IBOutlet weak var grossweight: UILabel!
    @IBOutlet weak var netweightkg: UILabel!
    @IBOutlet weak var netweightlbs: UILabel!
    @IBOutlet weak var grossweightkg: UILabel!
    @IBOutlet weak var grossweightlbs: UILabel!
    @IBOutlet weak var unitdesc: UILabel!
    @IBOutlet weak var productloc: UILabel!
    @IBOutlet weak var productnum: UILabel!
    @IBOutlet weak var productlocid: UILabel!
    @IBOutlet weak var shipped: UILabel!
    var inventory:InventoryItem?
    
    @IBOutlet weak var detailsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY, MMM d, HH:mm:ss"
        var formattedDate1 = dateFormatter.string(from: inventory!.createdDate)
        var formattedDate2 = dateFormatter.string(from: inventory!.entryDate)
        
        inventoryid.text = "\(inventory?.inventoryId ?? 0)"
        itemnum.text = "\(inventory?.itemNumber ?? "nil")"
        custname.text = "\(inventory?.customerName ?? "nil")"
        custid.text = "\(inventory?.customerId ?? 0)"
        matdesc.text = inventory?.materialDescription
        matid.text = "\(inventory?.materialId ?? 0)"
        del.text = inventory?.deleted
        created.text = formattedDate1
        contenttype.text = inventory?.contentType
        contentid.text = "\(inventory?.contentTypeId ?? 0)"
        entrydate.text = formattedDate2
        tareid.text = "\(inventory?.tareValueId ?? 0)"
        netweight.text = "\(inventory?.netWeight ?? 0)"
        grossweight.text = "\(inventory?.grossWeight ?? 0)"
        netweightkg.text = "\(inventory?.netWeightKg ?? 0)"
        netweightlbs.text = "\(inventory?.netWeightLbs ?? 0)"
        grossweightkg.text = "\(inventory?.grossWeightKg ?? 0)"
        grossweightlbs.text = "\(inventory?.grossWeightLbs ?? 0)"
        unitdesc.text = "\(inventory?.unitDescription ?? "nil")"
        productloc.text = "\(inventory?.productLocationDescription ?? "nil")"
        productnum.text = "\(inventory?.productNumberDescription ?? "nil")"
        productlocid.text = "\(inventory?.productLocationId ?? 0)"
        if inventory!.shipped{
            shipped.text = "YES"
        }else{
            shipped.text = "NO"
        }
    }
    
}
