//
//  HouseListViewController.swift
//  Westeros
//
//  Created by ATEmobile on 15/2/18.
//  Copyright © 2018 ATEmobile. All rights reserved.
//

import UIKit

// HouseListViewControllerDelegate: class {
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
    // Always Set LastSelected House as Selected
    override func viewWillAppear(_ animated: Bool) { super.viewWillAppear(animated)
        tableView.selectRow(at: IndexPath(row: self.lastSelectedRow, section: 0), animated: false, scrollPosition: .none)
    }
    
    // View Will Disappear:
    // Resets UISplitVC's Display Mode to .Automatic
    override func viewWillDisappear(_ animated: Bool) { super.viewWillAppear(animated)
        self.splitViewController?.preferredDisplayMode = .automatic
    }
    
    // On Row Selected:
    //  - Invokes Delegate
    //  - Notify Observers
    //  - Remember Row as Last Selected
    func onRowSelected(at indexPath: IndexPath) {
        let house = houses[indexPath.row]
 
        /* delegate */
        if (delegate != nil) { // Delegate
            delegate!.houseListViewController(self, didSelectHouse: house)
        }
        
        /* notify */
        let notification = Notification(name: HouseListViewController.HOUSEDIDCHANGE_NOTIFICATION, object: self, userInfo: [HouseListViewController.HOUSE_KEY: house])
        NotificationCenter.default.post(notification)
        
        /* set */
        self.lastSelectedRow = indexPath.row
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
        let cellId  = "HouseCell"
        let cell    = tableView.dequeueReusableCell(withIdentifier: cellId)
                    ?? UITableViewCell(style: .default, reuseIdentifier: cellId)
        
        /* donde */
        return(cell)
    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        /* set */
        let house = data.houses[indexPath.row]
        
        /* set */
        cell.imageView?.image  = house.sigilImage
        cell.textLabel?.text   = house.houseName
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.onRowSelected(at: indexPath)
    }
}





