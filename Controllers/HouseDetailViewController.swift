//
//  HouseDetailViewController.swift
//  Westeros
//
//  Created by ATEmobile on 12/2/18.
//  Copyright © 2018 ATEmobile. All rights reserved.
//

import UIKit

class HouseDetailViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var houseNameLabel: UILabel!
    @IBOutlet weak var sigilImageView: UIImageView!
    @IBOutlet weak var wordsLabel: UILabel!
    
    // MARK: - Properties
    let model: House
    
    // MARK: - Init
    init(model: House) {
        self.model = model
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
        self.title = model.name
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // View Loaded
    override func viewDidLoad() { super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    func syncModelWithView() {
        houseNameLabel.text = "House \(model.name)"
        sigilImageView.image = model.sigil.image
        wordsLabel.text = model.words
    }
    
    // View Appears/Disappears
    override func viewWillAppear(_ animated: Bool) { super.viewWillAppear(animated)
        print("View Will Appear [\(model.name)]")
        syncModelWithView();
    }
    override func viewDidAppear(_ animated: Bool) { super.viewDidAppear(animated)
        print("View Did Appear [\(model.name)]")
    }
    override func viewWillDisappear(_ animated: Bool) { super.viewWillDisappear(animated)
        print("View Will Disappear [\(model.name)]")
    }
    override func viewDidDisappear(_ animated: Bool) { super.viewDidDisappear(animated)
        print("View Did Disappear [\(model.name)]")
    }

    // System Memory Warning
    override func didReceiveMemoryWarning() { super.didReceiveMemoryWarning()
    }
}
