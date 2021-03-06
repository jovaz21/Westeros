//
//  EpisodeDetailViewController.swift
//  Westeros
//
//  Created by ATEmobile on 18/2/18.
//  Copyright © 2018 ATEmobile. All rights reserved.
//

import UIKit

// MARK: - Controller Stuff
class EpisodeDetailViewController: UIViewController {
    let model: Episode
    
    // MARK: - Init
    init(model: Episode) {
        
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
    //  - Adds Observer to SeasonListViewController's SEASONDIDCHANGE_NOTIFICATION
    //  - Paint UIView
    override func viewWillAppear(_ animated: Bool) { super.viewWillAppear(animated)

        // Add Observer
        NotificationCenter.default.addObserver(self, selector: #selector(seasonDidChange), name: SeasonListViewController.SEASONDIDCHANGE_NOTIFICATION, object: nil)
        
        // Paint UIView
        self.paintUIView()
    }
    @objc func seasonDidChange(notification: Notification) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // View Will Disappear
    // Remove Observer
    override func viewWillDisappear(_ animated: Bool) { super.viewWillAppear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Outlets for View Stuff
    @IBOutlet weak var episodeNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    // Paint UIView
    //  - Map Model Properties with View Data
    //  - Set UIView Data
    func paintUIView() {
        self.setUIViewData(EpisodeViewData(episodeName: model.name,
                                           date:        model.date))
    }
}

// MARK: - View Stuff
struct EpisodeViewData {
    let episodeName:    String
    let date:           Date
    var formattedDate:  String { return(date.toString()) }
    var text:           String { return("\(episodeName) (\(formattedDate))") }
}
extension EpisodeDetailViewController {
    
    // Setup UIView
    func setupUIView() { }
    
    // Set UIView Data
    //  - Formats the Date Label
    //  - Makes UIView Display: episodeName and formatted date
    func setUIViewData(_ data: EpisodeViewData) {
        episodeNameLabel.text = data.episodeName
        dateLabel.text        = "(( \(data.formattedDate) ))"
    }
}
