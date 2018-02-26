//
//  EpisodeListViewController.swift
//  Westeros
//
//  Created by ATEmobile on 18/2/18.
//  Copyright © 2018 ATEmobile. All rights reserved.
//

import UIKit

// MARK: - Controller Stuff
class EpisodeListViewController: UITableViewController {
    
    // MARK: - Properties
    var episodes: [Episode]
    
    // MARK: - Init
    init(episodes: [Episode]) {
        
        /* set */
        self.episodes = episodes
        
        /* set */
        super.init(style: UITableViewStyle.plain)
        title = "Episodes"
    }
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // View Will Appear
    // Adds Observer to SeasonListViewController's SEASONDIDCHANGE_NOTIFICATION
    override func viewWillAppear(_ animated: Bool) { super.viewWillAppear(animated)
        
        // Add Observer
        NotificationCenter.default.addObserver(self, selector: #selector(seasonDidChange), name: SeasonListViewController.SEASONDIDCHANGE_NOTIFICATION, object: nil)
    }
    @objc func seasonDidChange(notification: Notification) {
        
        /* check */
        guard let userInfo = notification.userInfo else {
            return
        }
        
        /* set */
        let newSeason = userInfo[SeasonListViewController.SEASON_KEY] as! Season
        
        /* set */
        self.episodes = newSeason.sortedEpisodes
        
        /* set */
        tableView.reloadData()
    }
    
    // View Will Disappear:
    //  - Set BackButton Title to 'Atrás'
    //  - Remove Observer if Out of NavigationController's Navigation Stack
    override func viewWillDisappear(_ animated: Bool) { super.viewWillAppear(animated)
        
        /* set */
        let backButton = UIBarButtonItem(title: "Atrás", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = backButton
        
        /* check */
        if (!(self.navigationController?.viewControllers.contains(self))!) {
            NotificationCenter.default.removeObserver(self)
        }
    }
    
    // On Row Selected:
    // Makes NavigationController Push a Newly Created EpisodeDetailViewController
    func onRowSelected(at indexPath: IndexPath) {
        let episodeDetailVC = EpisodeDetailViewController(model: episodes[indexPath.row])
        navigationController?.pushViewController(episodeDetailVC, animated: true)
    }
}

// MARK: - View Stuff
struct EpisodeListViewData {
    let episodes: [EpisodeViewData]
    let count: Int
}
extension EpisodeListViewController {
    var data: EpisodeListViewData {
        let episodes = self.episodes.map{ EpisodeViewData(episodeName:  $0.name,
                                                          date:         $0.date) }
        return(EpisodeListViewData(episodes: episodes, count: episodes.count))
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
        let cellId  = "EpisodeCell"
        let cell    = tableView.dequeueReusableCell(withIdentifier: cellId)
            ?? UITableViewCell(style: .default, reuseIdentifier: cellId)
        
        /* donde */
        return(cell)
    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        /* set */
        let episode = data.episodes[indexPath.row]
        
        /* set */
        cell.textLabel?.text = episode.text
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.onRowSelected(at: indexPath)
    }
}
