//
//  ScoresView.swift
//  TreasureHunt
//
//  Created by Krystyna Swider on 11/11/17.
//  Copyright © 2017 Nicole Ohel. All rights reserved.
//

import UIKit

class ScoresView: UIViewController {
    
    @IBOutlet weak var tableView:UITableView!
    var score:Int = Int()
    var total:Int = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension ScoresView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = "Score:"
        cell?.detailTextLabel?.text = "\(score)/\(total)"
        return cell!
    }
    
    
}

