//
//  SeasonListViewController.swift
//  Westeros
//
//  Created by ATEmobile on 18/2/18.
//  Copyright © 2018 ATEmobile. All rights reserved.
//

import UIKit

// MARK: - Controller Stuff
class SeasonListViewController: UITableViewController {
    let seasons: [Season]
    
    // MARK: - Init
    init(seasons: [Season]) {
        
        /* set */
        self.seasons = seasons
        
        /* set */
        super.init(style: UITableViewStyle.plain)
        title = "Temporadas"
    }
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // On Row Selected:
    // Makes NavigationController Push a Newly Created SeasonDetailViewController
    func onRowSelected(at indexPath: IndexPath) {
        let seasonDetailVC = SeasonDetailViewController(model: seasons[indexPath.row])
        navigationController?.pushViewController(seasonDetailVC, animated: true)
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
                                                       startDate:  $0.startDate) }
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
        let season = data.seasons[indexPath.row]
        
        /* set */
        let cellId  = "SeasonCell"
        var cell    = tableView.dequeueReusableCell(withIdentifier: cellId)
        if (cell == nil) {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        }
        
        /* set */
        cell?.textLabel?.text = season.text
        
        /* donde */
        return(cell!)
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.onRowSelected(at: indexPath)
    }
}
