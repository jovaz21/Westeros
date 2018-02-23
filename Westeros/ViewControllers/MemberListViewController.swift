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
    let members: [Person]
    
    // MARK: - Init
    init(members: [Person]) {
        
        /* set */
        self.members = members
        
        /* set */
        super.init(style: UITableViewStyle.plain)
        title = "Miembros"
    }
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
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
}
