//
//  MemberDetailViewController.swift
//  Westeros
//
//  Created by ATEmobile on 24/2/18.
//  Copyright © 2018 ATEmobile. All rights reserved.
//

import UIKit

// MARK: - Controller Stuff
class MemberDetailViewController: UIViewController {
    let model: Person
    
    // MARK: - Init
    init(model: Person) {
        
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
    //  - Adds Observer to HouseListViewController's HOUSEDIDCHANGE_NOTIFICATION
    //  - Paint UIView
    override func viewWillAppear(_ animated: Bool) { super.viewWillAppear(animated)
        
        // Add Observer
        NotificationCenter.default.addObserver(self, selector: #selector(houseDidChange), name: HouseListViewController.HOUSEDIDCHANGE_NOTIFICATION, object: nil)
        
        // Paint UIView
        self.paintUIView()
    }
    @objc func houseDidChange(notification: Notification) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // View Will Disappear
    // Remove Observer
    override func viewWillDisappear(_ animated: Bool) { super.viewWillAppear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Outlets for View Stuff
    @IBOutlet weak var personNameLabel: UILabel!
    @IBOutlet weak var aliasLabel: UILabel!
    
    // Paint UIView
    //  - Map Model Properties with View Data
    //  - Set UIView Data
    func paintUIView() {
        self.setUIViewData(PersonViewData(name:   model.name,
                                          alias:  model.alias))
    }
}

// MARK: - View Stuff
extension PersonViewData {
    var formattedAlias: String {
        
        /* check */
        if (alias == "") {
            return("")
        }
        return("(\(alias))")
    }
}
extension MemberDetailViewController {
    
    // Setup UIView
    func setupUIView() { }
    
    // Set UIView Data
    //  - Formats the Date Label
    //  - Makes UIView Display: personName and formatted alias
    func setUIViewData(_ data: PersonViewData) {
        personNameLabel.text  = data.name
        aliasLabel.text       = data.formattedAlias
    }
}
