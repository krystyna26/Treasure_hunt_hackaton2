//
//  Play.swift
//  TreasureHunt
//
//  Created by Krystyna Swider on 11/11/17.
//  Copyright © 2017 Nicole Ohel. All rights reserved.
//

import UIKit
import CoreData
import GoogleMaps

class Play: UIViewController {
    
    var thisHunt:Hunt?
    var numTreasures:Int?
    var allTreasures:[Treasure] = []
    var closeTreasure:Treasure?
    let locationManager = CLLocationManager()
    var treasureLocations = [CLLocation]()
    var score = 0
    var zoom:Float = 18.0
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // outlets
    @IBOutlet weak var nameOfHuntLabel: UILabel!
    @IBOutlet weak var youAreCloseOPTLabel: UILabel! // hide and show
    @IBOutlet weak var map: GMSMapView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var showFoundItButton: UIButton! // hide and show
    @IBOutlet weak var zoomStepper: UIStepper!
    
    
    
    
    func getAllTreasures() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Treasure")
        request.predicate = NSPredicate(format: "hunt == %@", thisHunt!)
        do {
            let result = try context.fetch(request)
            numTreasures = result.count
            allTreasures = result as! [Treasure]
        } catch {
            print(error)
        }
    }
    
    //show label and button "found it" when you are 5m from treasure
    func amIClose(){
        for t in allTreasures {
            let loc = CLLocation(latitude: t.latitude, longitude: t.longitude)
            let distance = locationManager.location?.distance(from: loc)
            print("SOMETHING HAPPENING")
            if let d = distance {
                print(d)
                if d < 12.0 {
                    youAreCloseOPTLabel.isHidden = false
                    youAreCloseOPTLabel.textColor = .black
                    showFoundItButton.isHidden = false
                    closeTreasure = t
                    youAreCloseOPTLabel.text = "You are close to \(closeTreasure?.name ?? "a treasure")!!"
                    //                    print("YOU ARE CLOSE")
                    //                    print(d)
                    if d < 8.0 {
                        youAreCloseOPTLabel.text = "YOUR SO SO CLOSE!"
                        youAreCloseOPTLabel.textColor = .green
                    }
                } else {
                    youAreCloseOPTLabel.isHidden = true
                    showFoundItButton.isHidden = true
                }
            }
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "finishSegue" {
            let dest = segue.destination as! ScoresView
            dest.score = score
            dest.total = numTreasures!
        }
    }
    
    @IBAction func foundItButtonClicked(_ sender: UIButton) {
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: closeTreasure!.latitude, longitude: closeTreasure!.longitude)
        marker.title = closeTreasure!.name
        marker.map = map
        score += 1
        scoreLabel.text = String(score)
        if let index = allTreasures.index(of: closeTreasure!) {
            allTreasures.remove(at: index)
        }
        youAreCloseOPTLabel.isHidden = true
        showFoundItButton.isHidden = true
    }
    
    
    // view did load
    override func viewDidLoad() {
        super .viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        nameOfHuntLabel.text = thisHunt?.name
        // when ?
        youAreCloseOPTLabel.isHidden = true
        scoreLabel.text = String(score)
        // when ?
        showFoundItButton.isHidden = true
        getAllTreasures()
        zoomStepper.value = Double(zoom)
    }
    
    func showMap() {
        let locCoordinate:CLLocationCoordinate2D? = locationManager.location?.coordinate
        if let coordinate = locCoordinate {
            let camera = GMSCameraPosition.camera(withLatitude: coordinate.latitude, longitude: coordinate.longitude, zoom: zoom)
            map.camera = camera //Puts the map centered around your location
            map.isMyLocationEnabled = true
            
        }
    }
    @IBAction func zoomPressed(_ sender: UIStepper) {
        zoom = Float(sender.value)
        print("Zoom: \(zoom)")
        showMap()
    }
}



extension Play: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        showMap()
        amIClose()
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    }
}

