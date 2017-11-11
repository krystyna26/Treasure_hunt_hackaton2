//
//  HomeVC.swift
//  TreasureHunt
//
//  Created by Nicole Ohel on 11/10/17.
//  Copyright © 2017 Nicole Ohel. All rights reserved.
//

import UIKit
import CoreData

class HomeVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var treasureHunts = [Hunt]()
    
    let AppDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllHunts()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func getAllHunts() {
        do {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Hunt")
            let results = try context.fetch(request)
            treasureHunts = results as! [Hunt]
        } catch {
            print("Error: \(error)")
        }
    }
    
    
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return treasureHunts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "huntCell") as! HuntCell
        let hunt = treasureHunts[indexPath.row]
        
        cell.nameLabel.text = hunt.name
        cell.descLabel.text = hunt.desc
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let huntToDelete = treasureHunts.remove(at: indexPath.row)
        context.delete(huntToDelete)
        AppDelegate.saveContext()
        tableView.reloadData()
    }
    
    
}
