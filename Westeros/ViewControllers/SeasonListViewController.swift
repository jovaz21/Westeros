//
//  SeasonListViewController.swift
//  Westeros
//
//  Created by ATEmobile on 18/2/18.
//  Copyright © 2018 ATEmobile. All rights reserved.
//

import UIKit

// SeasonListViewControllerDelegate: class {
protocol SeasonListViewControllerDelegate: AnyObject {
    func seasonListViewController(_ vc: SeasonListViewController, didSelectSeason season: Season)
}

// MARK: - Controller Stuff
class SeasonListViewController: UITableViewController {
    static let SEASONDIDCHANGE_NOTIFICATION = Notification.Name("SeasonDidChangeNotification")
    static let SEASON_KEY                   = "SeasonKey"
    
    // MARK: - Properties
    let seasons: [Season]
    
    // Last Selected Season/Row
    var lastSelectedSeason: Season { return(seasons[lastSelectedRow]) }
    var lastSelectedRow: Int {
        get {
            return(UserDefaults.standard.integer(forKey: "SeasonListView.LastSelectedRow"))
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "SeasonListView.LastSelectedRow")
            UserDefaults.standard.synchronize()
        }
    }
    
    // Delegate
    weak var delegate: SeasonListViewControllerDelegate?
    
    // MARK: - Init
    init(seasons: [Season]) {
        
        /* set */
        self.seasons = seasons
        
        /* set */
        super.init(style: UITableViewStyle.plain)
        title = "Temporadas"
    }
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // View Will Appear:
    // Always Set LastSelected Season as Selected
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
        let season = seasons[indexPath.row]
        
        /* delegate */
        if (delegate != nil) { // Delegate
            delegate!.seasonListViewController(self, didSelectSeason: season)
        }
        
        /* notify */
        let notification = Notification(name: SeasonListViewController.SEASONDIDCHANGE_NOTIFICATION, object: self, userInfo: [SeasonListViewController.SEASON_KEY: season])
        NotificationCenter.default.post(notification)
        
        /* set */
        self.lastSelectedRow = indexPath.row
    }
}

// MARK: - View Stuff
struct SeasonListViewData {
    let seasons: [SeasonViewData]
    let count: Int
}
extension SeasonListViewController {
    var data: SeasonListViewData {
        let seasons = self.seasons.map{ SeasonViewData(seasonName:  $0.name,
                                                       startDate:   $0.startDate) }
        return(SeasonListViewData(seasons: seasons, count: seasons.count))
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
        let cellId  = "SeasonCell"
        let cell    = tableView.dequeueReusableCell(withIdentifier: cellId)
            ?? UITableViewCell(style: .default, reuseIdentifier: cellId)
        
        /* donde */
        return(cell)
    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        /* set */
        let season = data.seasons[indexPath.row]
        
        /* set */
        cell.textLabel?.text = season.text
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.onRowSelected(at: indexPath)
    }
}
