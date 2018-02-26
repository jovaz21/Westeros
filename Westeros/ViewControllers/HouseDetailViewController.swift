//
//  HouseDetailViewController.swift
//  Westeros
//
//  Created by ATEmobile on 12/2/18.
//  Copyright © 2018 ATEmobile. All rights reserved.
//

import UIKit

// MARK: - Controller Stuff
class HouseDetailViewController: UIViewController {
    var model: House
    
    // MARK: - Init
    init(model: House) {
        
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
    
    // On DisplayWiki:
    // Makes NavigationController Push a Newly Created WikiViewController
    func onDisplayWiki() {
        let wikiVC = WikiViewController(model: model)
        navigationController?.pushViewController(wikiVC, animated: true)
    }
    
    // On DisplayMembers:
    // Makes NavigationController Push a Newly Created MemberListViewController
    func onDisplayMembers() {
        let memberListVC = MemberListViewController(members: model.sortedMembers)
        navigationController?.pushViewController(memberListVC, animated: true)
    }

    // MARK: - Outlets for View Stuff
    @IBOutlet weak var houseNameLabel: UILabel!
    @IBOutlet weak var sigilImageView: UIImageView!
    @IBOutlet weak var wordsLabel: UILabel!
    
    // Paint UIView
    //  - Map Model Properties with View Data
    //  - Set UIView Data
    func paintUIView() {
        self.setUIViewData(HouseViewData(houseName:     model.name,
                                         sigilImage:    model.sigil.image,
                                         houseWords:    model.words))
    }
}

// MARK: - View Stuff
struct HouseViewData {
    let houseName:  String
    let sigilImage: UIImage
    let houseWords: String
}
extension HouseDetailViewController {
    
    // Setup UIView:
    //  - Creates a UIBarButtonItem so that Users can Navigate to the Wiki Page of the House
    //  - Creates a UIBarButtonItem so that Users can Access the Sorted Members List
    func setupUIView() {
        
        /* create */
        let wikiButton = UIBarButtonItem(title: "Wiki", style: .plain, target: self, action: #selector(wikiButtonAction))
        let membersButton = UIBarButtonItem(title: "Members", style: .plain, target: self, action: #selector(membersButtonAction))
        
        /* set */
        navigationItem.rightBarButtonItems = [wikiButton, membersButton]
    }
    @objc func wikiButtonAction() { DispatchQueue.main.asyncAfter(deadline: .now() + 0.025, execute: {
        self.onDisplayWiki()
    })}
    @objc func membersButtonAction() { DispatchQueue.main.asyncAfter(deadline: .now() + 0.025, execute: {
        self.onDisplayMembers()
    })}
    
    // Set UIView Data:
    //  - Formats the House Name Literal
    //  - Makes UIView Display: houseName, sigilImage and words
    func setUIViewData(_ data: HouseViewData) {
        houseNameLabel.text     = "Casa \(data.houseName)"
        sigilImageView.image    = data.sigilImage
        wordsLabel.text         = "\"\(data.houseWords)\""
    }
}

// MARK: - HouseListViewControllerDelegate
extension HouseDetailViewController: HouseListViewControllerDelegate {
    func houseListViewController(_ houseListVC: HouseListViewController, didSelectHouse house: House) {
        
        /* set */
        self.model = house
        
        /* set */
        self.title = house.name
        
        /* check */
        if (houseListVC.splitViewController!.isCollapsed) {
            houseListVC.showDetailViewController(self, sender: houseListVC)
        }
        else {
            
            /* paint */
            paintUIView()
            
            /* check */
            if (houseListVC.splitViewController!.displayMode == .primaryOverlay) {
                houseListVC.splitViewController?.preferredDisplayMode = .primaryHidden
            }
        }
        
        /* done */
        return
    }
}
