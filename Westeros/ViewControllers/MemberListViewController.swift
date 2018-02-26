//
//  MemberListViewController.swift
//  Westeros
//
//  Created by ATEmobile on 18/2/18.
//  Copyright © 2018 ATEmobile. All rights reserved.
//

import UIKit

// MARK: - Controller Stuff
class MemberListViewController: UITableViewController {
    
    // MARK: - Properties
    var members: [Person]
    
    // MARK: - Init
    init(members: [Person]) {
        
        /* set */
        self.members = members
        
        /* set */
        super.init(style: UITableViewStyle.plain)
        title = "Miembros"
    }
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // View Will Appear
    // Adds Observer to HouseListViewController's HOUSEDIDCHANGE_NOTIFICATION
    override func viewWillAppear(_ animated: Bool) { super.viewWillAppear(animated)
        
        // Add Observer
        NotificationCenter.default.addObserver(self, selector: #selector(houseDidChange), name: HouseListViewController.HOUSEDIDCHANGE_NOTIFICATION, object: nil)
    }
    @objc func houseDidChange(notification: Notification) {
        
        /* check */
        guard let userInfo = notification.userInfo else {
            return
        }
        
        /* set */
        let newHouse = userInfo[HouseListViewController.HOUSE_KEY] as! House
        
        /* set */
        self.members = newHouse.sortedMembers
        
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
    // Makes NavigationController Push a Newly Created MemberDetailViewController
    func onRowSelected(at indexPath: IndexPath) {
        let memberDetailVC = MemberDetailViewController(model: members[indexPath.row])
        navigationController?.pushViewController(memberDetailVC, animated: true)
    }
}

// MARK: - View Stuff
struct PersonViewData {
    let name: String
    let alias: String
    var text: String {
        var res = self.name
        if (self.alias != "") {
            res = "\(res) (\(self.alias))"
        }
        return(res)
    }
}
struct MemberListViewData {
    let members: [PersonViewData]
    let count: Int
}
extension MemberListViewController {
    var data: MemberListViewData {
        let members = self.members.map{ PersonViewData(name:    $0.name,
                                                       alias:   $0.alias) }
        return(MemberListViewData(members: members, count: members.count))
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
        let cellId  = "MemberCell"
        let cell    = tableView.dequeueReusableCell(withIdentifier: cellId)
                    ?? UITableViewCell(style: .default, reuseIdentifier: cellId)
        
        /* donde */
        return(cell)
    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        /* set */
        let person = data.members[indexPath.row]
        
        /* set */
        cell.textLabel?.text = person.text
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.onRowSelected(at: indexPath)
    }
}
