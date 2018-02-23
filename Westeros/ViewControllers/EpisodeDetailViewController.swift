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
    // Makes UIView Display/Paint HouseViewData
    override func viewWillAppear(_ animated: Bool) { super.viewWillAppear(animated)
        self.setUIViewData(EpisodeViewData(episodeName: model.name,
                                           date:        model.date))
    }
    
    // MARK: - Outlets for View Stuff
    @IBOutlet weak var episodeNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
}

// MARK: - View Stuff
struct EpisodeViewData {
    let episodeName: String
    let date:  Date
    var formattedDate: String {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withFullDate, .withDashSeparatorInDate]
        return(dateFormatter.string(from: date))
    }
    var text: String {
        return("\(episodeName) (\(formattedDate))")
    }
}
extension EpisodeDetailViewController {
    
    // Setup UIView
    func setupUIView() { }
    
    // Set UIView Data
    func setUIViewData(_ data: EpisodeViewData) {
        episodeNameLabel.text = data.episodeName
        dateLabel.text        = "(( \(data.formattedDate) ))"
    }
}
