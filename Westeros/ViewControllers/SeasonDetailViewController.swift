//
//  SeasonDetailViewController.swift
//  Westeros
//
//  Created by ATEmobile on 18/2/18.
//  Copyright © 2018 ATEmobile. All rights reserved.
//

import UIKit

// MARK: - Controller Stuff
class SeasonDetailViewController: UIViewController {
    var model: Season
    
    // MARK: - Init
    init(model: Season) {
        
        /* set */
        self.model = model
        
        /* set */
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
        self.title = model.name
    }
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // View Is Loaded:
    // Setup UIView Layer
    override func viewDidLoad() { super.viewDidLoad()
        self.setupUIView()
    }
    
    // View Will Appear:
    // Paint UIView
    override func viewWillAppear(_ animated: Bool) { super.viewWillAppear(animated)
        self.paintUIView()
    }
    
    // View Will Disappear:
    // Set BackButton Title to 'Atrás'
    override func viewWillDisappear(_ animated: Bool) { super.viewWillAppear(animated)
        let backButton = UIBarButtonItem(title: "Atrás", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = backButton
    }
    
    // On DisplayEpisodes:
    // Makes NavigationController Push a Newly Created EpisodeListViewController
    func onDisplayEpisodes() {
        let episodeListVC = EpisodeListViewController(episodes: model.sortedEpisodes)
        navigationController?.pushViewController(episodeListVC, animated: true)
    }
    
    // MARK: - Outlets for View Stuff
    @IBOutlet weak var seasonNameLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    
    // Paint UIView
    //  - Map Model Properties with View Data
    //  - Set UIView Data
    func paintUIView() {
        self.setUIViewData(SeasonViewData(seasonName:   model.name,
                                          startDate:    model.startDate))
    }
}

// MARK: - View Stuff
struct SeasonViewData {
    let seasonName:         String
    let startDate:          Date
    var formattedStartDate: String { return(startDate.toString()) }
    var text:               String { return("\(seasonName) (\(formattedStartDate))") }
}
extension SeasonDetailViewController {
    
    // Setup UIView
    // Creates a UIBarButtonItem so that Users can Access the Sorted Episodes List
    func setupUIView() {
        
        /* create */
        let episodesButton = UIBarButtonItem(title: "Episodes", style: .plain, target: self, action: #selector(episodesButtonAction))
        
        /* set */
        navigationItem.rightBarButtonItems = [episodesButton]
    }
    @objc func episodesButtonAction() { DispatchQueue.main.asyncAfter(deadline: .now() + 0.025, execute: {
        self.onDisplayEpisodes()
    })}
    
    // Set UIView Data
    //  - Formats the Start Date Label
    //  - Makes UIView Display: seasonName and formatted startDate
    func setUIViewData(_ data: SeasonViewData) {
        seasonNameLabel.text    = data.seasonName
        startDateLabel.text     = "(( \(data.formattedStartDate) ))"
    }
}

// MARK: - SeasonListViewControllerDelegate
extension SeasonDetailViewController: SeasonListViewControllerDelegate {
    func seasonListViewController(_ seasonListVC: SeasonListViewController, didSelectSeason season: Season) {
        
        /* set */
        self.model = season
        
        /* set */
        self.title = season.name
        
        /* check */
        if (seasonListVC.splitViewController!.isCollapsed) {
            seasonListVC.showDetailViewController(self, sender: seasonListVC)
        }
        else {
            
            /* paint */
            paintUIView()
            
            /* check */
            if (seasonListVC.splitViewController!.displayMode == .primaryOverlay) {
                seasonListVC.splitViewController?.preferredDisplayMode = .primaryHidden
            }
        }
        
        /* done */
        return
    }
}
