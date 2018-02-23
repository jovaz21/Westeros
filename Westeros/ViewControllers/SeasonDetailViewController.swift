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
    let model: Season
    
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
    // Makes UIView Display/Paint HouseViewData
    override func viewWillAppear(_ animated: Bool) { super.viewWillAppear(animated)
        self.setUIViewData(SeasonViewData(seasonName:   model.name,
                                          startDate:    model.startDate))
    }
    
    // MARK: - Outlets for View Stuff
    @IBOutlet weak var seasonNameLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
}

// MARK: - View Stuff
struct SeasonViewData {
    let seasonName: String
    let startDate:  Date
    var formattedStartDate: String {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withFullDate, .withDashSeparatorInDate]
        return(dateFormatter.string(from: startDate))
    }
    var text: String {
        return("\(seasonName) (\(formattedStartDate))")
    }
}
extension SeasonDetailViewController {
    
    // Setup UIView
    func setupUIView() { }
    
    // Set UIView Data
    func setUIViewData(_ data: SeasonViewData) {
        seasonNameLabel.text    = data.seasonName
        startDateLabel.text     = "(( \(data.formattedStartDate) ))"
    }
}
