//
//  HouseListViewController.swift
//  Westeros
//
//  Created by ATEmobile on 15/2/18.
//  Copyright © 2018 ATEmobile. All rights reserved.
//

import UIKit

//protocol HouseListViewControllerDelegate: class {
protocol HouseListViewControllerDelegate: AnyObject {
    func houseListViewController(_ vc: HouseListViewController, didSelectHouse house: House)
}

// MARK: - Controller Stuff
class HouseListViewController: UITableViewController {
    static let HOUSEDIDCHANGE_NOTIFICATION = Notification.Name("HouseDidChangeNotification")
    static let HOUSE_KEY                   = "HouseKey"

    // MARK: - Properties
    let houses: [House]
    
    // Last Selected House/Row
    var lastSelectedHouse: House { return(houses[lastSelectedRow]) }
    var lastSelectedRow: Int {
        get {
            return(UserDefaults.standard.integer(forKey: "HouseListView.LastSelectedRow"))
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "HouseListView.LastSelectedRow")
            UserDefaults.standard.synchronize()
        }
    }
    
    // Delegate
    weak var delegate: HouseListViewControllerDelegate?
    
    // MARK: - Init
    init(houses: [House]) {
        
        /* set */
        self.houses = houses
        
        /* set */
        super.init(style: UITableViewStyle.plain)
        title = "Westeros"
    }
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // View Will Appear:
    // Marks Always LastSelected House as Selected
    override func viewWillAppear(_ animated: Bool) { super.viewWillAppear(animated)
        tableView.selectRow(at: IndexPath(row: self.lastSelectedRow, section: 0), animated: true, scrollPosition: .none)
    }
    
    // View Will Disappear:
    // Resets UISplitVC's Display Mode to .Automatic
    override func viewWillDisappear(_ animated: Bool) { super.viewWillAppear(animated)
        self.splitViewController?.preferredDisplayMode = .automatic
    }
    
    // On Row Selected:
    // Makes NavigationController Push a Newly Created HouseDetailViewController
    func onRowSelected(at indexPath: IndexPath) {
        let house = houses[indexPath.row]
 
        /* check */
        if (delegate != nil) { // Delegate
            delegate!.houseListViewController(self, didSelectHouse: house)
        }
        
        // Notify House Did Change to Observers
        let notification = Notification(name: HouseListViewController.HOUSEDIDCHANGE_NOTIFICATION, object: self, userInfo: [HouseListViewController.HOUSE_KEY: house])
        NotificationCenter.default.post(notification)
        
        // Save Selected Row
        self.lastSelectedRow = indexPath.row
        
        /* done */
        return
    }
}

// MARK: - View Stuff
struct HouseListViewData {
    let houses: [HouseViewData]
    let count: Int
}
extension HouseListViewController {
    var data: HouseListViewData {
        let houses = self.houses.map{ HouseViewData(houseName:  $0.name,
                                                   sigilImage:  $0.sigil.image,
                                                   houseWords:  $0.words) }
        return(HouseListViewData(houses: houses, count: houses.count))
    }
    
    // Table View Delegate Functions
    override func numberOfSections(in tableView: UITableView) -> Int {
        return(1)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(data.count)
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /* set */
        let house = data.houses[indexPath.row]
        
        /* set */
        let cellId  = "HouseCell"
        var cell    = tableView.dequeueReusableCell(withIdentifier: cellId)
        if (cell == nil) {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        }
        
        /* set */
        cell?.imageView?.image  = house.sigilImage
        cell?.textLabel?.text   = house.houseName
        
        /* check */
        if (indexPath.row == self.lastSelectedRow) {
            cell?.setHighlighted(true, animated: false)
        }
        
        /* donde */
        return(cell!)
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.onRowSelected(at: indexPath)
    }
}





