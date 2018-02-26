//
//  WesterosViewController.swift
//  Westeros
//
//  Created by ATEmobile on 24/2/18.
//  Copyright © 2018 ATEmobile. All rights reserved.
//

import UIKit

class WesterosViewController: UISplitViewController {
    
    // MARK: - Properties
    let listVCItems:    [UIViewController]
    let detailVCItems:  [UIViewController]
    
    // Last Selected TabIndex
    var lastSelectedListVC: UIViewController    { return(listVCItems[lastSelectedTabIndex]) }
    var lastSelectedDetailVC: UIViewController  { return(detailVCItems[lastSelectedTabIndex]) }
    var lastSelectedTabIndex: Int {
        get {
            return(UserDefaults.standard.integer(forKey: "WesterosView.LastSelectedTabIndex"))
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "WesterosView.LastSelectedTabIndex")
            UserDefaults.standard.synchronize()
        }
    }
    
    // MARK: - Init
    init() {
        let houseListVC     = HouseListViewController(houses: Repository.local.houses)
        let houseDetailVC   = HouseDetailViewController(model: houseListVC.lastSelectedHouse)
        let seasonListVC    = SeasonListViewController(seasons: Repository.local.seasons)
        let seasonDetailVC  = SeasonDetailViewController(model: seasonListVC.lastSelectedSeason)
        
        /* set */
        houseListVC.delegate    = houseDetailVC
        seasonListVC.delegate   = seasonDetailVC

        /* set */
        self.listVCItems    = [houseListVC, seasonListVC]
        self.detailVCItems  = [houseDetailVC, seasonDetailVC]
        
        /* */
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
        
        /* reset */
        self.lastSelectedTabIndex = 0

        // UITabBar :: Houses + Seasons
        let tbc = UITabBarController()
            tbc.delegate        = self
            tbc.viewControllers = self.listVCItems.map { return($0.wrappedInNavigation()) }
            tbc.selectedIndex   = self.lastSelectedTabIndex
        
        /* set */
        self.viewControllers = [tbc, self.lastSelectedDetailVC.wrappedInNavigation()]
        
        /* */
        self.setupDisplayModeButton()
        
        /* set */
        self.delegate = self
    }
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

// MARK: - UITabBarControllerDelegate:
//  - If SplitView is Collapsed, Pops Current ListVC's NavigationController to RootController
//  - If SplitView is Not Collapsed, Makes DetailVC Automatically Shown upon TabBar Transitions
extension WesterosViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        /* check */
        if (tabBarController.selectedIndex == self.lastSelectedTabIndex) {
            return
        }
        if (self.isCollapsed) { // POP Current List's Navigation Controller to Root Controller
            self.lastSelectedListVC.navigationController?.popToRootViewController(animated: false)
        }
        
        /* set */
        self.lastSelectedTabIndex = tabBarController.selectedIndex
        
        /* check */
        if (!self.isCollapsed) { // Show DetailVC (Wrapped In a New Navigation Controller)
            self.showDetailViewController(self.lastSelectedDetailVC.wrappedInNavigation(), sender: self)
        }
    }
}

// MARK: - UISplitViewControllerDelegate:
// Makes App Working Fine on any iPhone/iPad (Universal)... When UITabBarController is set as the master view controller, the default behaviour on iPhone 4, 5, 6, etc (compact) upon a cell selection is, instead of getting a push transition, to get a modal transition
extension WesterosViewController: UISplitViewControllerDelegate {
  
    // Show Detail:
    // When SplitView is Collapsed and 'showDetail' is Invoked upon a Cell Selection, then PUSH DetailVC into the Navigation Stack of the ListVC's NavigationController
    func splitViewController(_ splitViewController: UISplitViewController,
                             showDetail vc: UIViewController,
                             sender: Any?) -> Bool {

        /* check */
        if (!splitViewController.isCollapsed) { // If Not Collapsed, Okay, Use Default Behaviour...
            return(false)
        }
        if (!(sender is UITableViewController)) { // If Not Invoked upon Cell Selection, Okay...
            return(false)
        }
        
        /* */
        let detailVC    = vc
        let listVC      = sender as! UITableViewController

        /* push */
        listVC.navigationController?.pushViewController(detailVC, animated: true)
        return(true)
    }
    
    // Separate Secondary from Primary:
    // When Back from 'Compact' to 'Regular' Horizontal Width (i.e. iPhone 8 Plus portrait => landscape), then POP DetailVC from the Navigation Stack of the ListVC's NavigationController (if needed) and return it (Wrapped in a New NavigationController) to the SplitViewController
    func splitViewController(_ splitViewController: UISplitViewController, separateSecondaryFrom primaryViewController: UIViewController) -> UIViewController? {
        let listVC      = self.lastSelectedListVC
        let detailVC    = self.lastSelectedDetailVC
        
        /* check */
        if (listVC.navigationController?.topViewController == detailVC) {
            listVC.navigationController?.popViewController(animated: false)
        }
        
        /* done */
        return(detailVC.wrappedInNavigation())
    }
    
    // Hide/Show DisplayButtonItem According to Current Display Mode
    private func splitViewController(_ svc: UISplitViewController, didChangeTo displayMode: UISplitViewControllerDisplayMode) { self.setupDisplayModeButton() }
    func setupDisplayModeButton() {
        
        /* check */
        if (self.isCollapsed) {
            return
        }
        
        /* check */
        if (self.displayMode == .allVisible) {
            self.lastSelectedDetailVC.navigationItem.leftBarButtonItem = nil
        }
        else {
            self.lastSelectedDetailVC.navigationItem.leftBarButtonItem = self.displayModeButtonItem
        }
    }
}
