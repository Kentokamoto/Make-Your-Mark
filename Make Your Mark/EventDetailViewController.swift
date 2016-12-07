//
//  EventDetailViewController.swift
//  Make Your Mark
//
//  Created by Kento Okamoto on 12/6/16.
//  Copyright © 2016 Kento Okamoto. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    var event : Event!
    // Outlet Variables
    @IBOutlet weak var competitionNameLabel: UILabel!
    @IBOutlet weak var competitionNumberLabel: UILabel!
    @IBOutlet weak var seasonLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var eventTypeLabel: UILabel!
    @IBOutlet weak var measurementLabel: UILabel!
    @IBOutlet weak var numOfFlightsLabel: UILabel!
    @IBOutlet weak var athletesInFinalLabel: UILabel!
    @IBOutlet weak var provoMarkLabel: UILabel!
    @IBOutlet weak var autoMarkLabel: UILabel!
    @IBOutlet weak var flightTableView: UITableView!
    @IBOutlet weak var competitionNameNavLabel: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateLabels()
    }

    func updateLabels(){
        competitionNameNavLabel.title = event?.competitionName
        competitionNameLabel.text = event?.competitionName
        competitionNumberLabel.text = event?.competitionNumber
        seasonLabel.text = event?.season
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy hh:mm aa"
        dateTimeLabel.text = dateFormatter.string(from: event?.eventDateTime as! Date )
        genderLabel.text = event?.gender
        eventTypeLabel.text = event?.eventType
        measurementLabel.text = event?.measurement
        numOfFlightsLabel.text = String(describing: event.numberOfFlights)
        athletesInFinalLabel.text = String(describing: event.athletesInFinal)
        provoMarkLabel.text = String(describing: event.provisionalMark)
        autoMarkLabel.text = String(describing: event.automaticMark)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (event!.flights?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.flightTableView.dequeueReusableCell(withIdentifier: "flightIdentifier")
        let flight = event?.flights?.object(at: indexPath.row) as! Flight
        
        cell?.textLabel?.text = "Flight Number: " + String(describing: flight.flightNumber)
        
        return cell!
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "flightLogSegue" {
            print("Lets Go!")
        }
    }
    
}
