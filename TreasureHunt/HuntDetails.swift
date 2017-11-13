//
//  HuntDetails.swift
//  TreasureHunt
//
//  Created by Krystyna Swider on 11/11/17.
//  Copyright © 2017 Nicole Ohel. All rights reserved.
//

import UIKit
import CoreData
class HuntDetails: UIViewController {
    
    var thisHunt:Hunt?
    var numTreasures:Int?
    let AppDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numOfTreasuresLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func getNumberOfTreasures() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Treasure")
        request.predicate = NSPredicate(format: "hunt == %@", thisHunt!)
        do {
            let result = try context.fetch(request)
            numTreasures = result.count
            
        } catch {
            print(error)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "playSegue" {
            let dest = segue.destination as! Play
            dest.thisHunt = thisHunt
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getNumberOfTreasures()
        numOfTreasuresLabel.text = String(numTreasures!)
        nameLabel.text = thisHunt?.name
        descriptionLabel.text = thisHunt?.desc
    }
}

