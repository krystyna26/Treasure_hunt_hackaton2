//
//  NewHuntVC.swift
//  TreasureHunt
//
//  Created by Nicole Ohel on 11/10/17.
//  Copyright © 2017 Nicole Ohel. All rights reserved.
//

import UIKit
import CoreData

class NewHuntVC: UIViewController {
    var huntName:String?
    
    @IBOutlet weak var huntNameField:UITextField!
    @IBOutlet weak var huntDescField:UITextField!
    
    
    let AppDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addTreasureSegue" {
            let nav = segue.destination as! UINavigationController
            let dest = nav.topViewController as! AddTreasuresVC
            let hunt = sender as! Hunt
            dest.huntName = huntName
            dest.thisHunt = hunt
        }
    }
    
    @IBAction func textFieldChanged(_ sender: UITextField) {
        sender.backgroundColor = .clear
    }
    
    @IBAction func nextButtonPressed(_ sender:UIBarButtonItem) {
        if (huntNameField.text != nil && huntDescField != nil) {
            let name = huntNameField.text
            let desc = huntDescField.text
            let warningColor = UIColor(red:1.00, green:0.00, blue:0.00, alpha:0.2)
            if name == "" {
                huntNameField.backgroundColor = warningColor
            }
            if desc == "" {
                huntDescField.backgroundColor = warningColor
            }
            if name != "" && desc != "" {
                huntName = name
                let hunt = NSEntityDescription.insertNewObject(forEntityName: "Hunt", into: context) as! Hunt
                hunt.name = name
                hunt.desc = desc
                AppDelegate.saveContext()
                performSegue(withIdentifier: "addTreasureSegue", sender: hunt)
                
            }

        }
        
    }
}
