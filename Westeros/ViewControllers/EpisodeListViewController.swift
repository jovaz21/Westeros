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
    let episodes: [Episode]
    
    // MARK: - Init
    init(episodes: [Episode]) {
        
        /* set */
        self.episodes = episodes
        
        /* set */
        super.init(style: UITableViewStyle.plain)
        title = "Episodios"
    }
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
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
                                                          date:  $0.date) }
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
        let episode = data.episodes[indexPath.row]
        
        /* set */
        let cellId  = "EpisodeCell"
        var cell    = tableView.dequeueReusableCell(withIdentifier: cellId)
        if (cell == nil) {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        }
        
        /* set */
        cell?.textLabel?.text = episode.text
        
        /* donde */
        return(cell!)
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.onRowSelected(at: indexPath)
    }
}
