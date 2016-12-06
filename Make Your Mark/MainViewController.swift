//
//  ViewController.swift
//  Make Your Mark
//
//  Created by Kento Okamoto on 10/31/16.
//  Copyright © 2016 Kento Okamoto. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: UITableViewController{
    /*
     * Variables
     */
    var events = [Event]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Required for TableViewDataSource and UITableViewDelegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCellIdenitifier", for: indexPath) as! MainTableViewCell
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy 'at' HH:mm"
        
        let event = events[indexPath.row]
        cell.competitionNameLabel?.text = event.value(forKey: "competitionName") as? String
        //cell.dateLabel?.text = event.value(forKey: "eventDateTime") as? String
        cell.eventTypeLabel?.text = event.value(forKey: "eventType") as? String
        cell.genderLabel?.text = event.value(forKey: "gender" ) as? String
        
        return cell
    }
    
    
    //     // Override to support conditional editing of the table view.
    //     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    //     // Return false if you do not want the specified item to be editable.
    //     return true
    //     }
    //
    //
    //
    //     // Override to support editing the table view.
    //     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    //     if editingStyle == .delete {
    //     // Delete the row from the data source
    //     tableView.deleteRows(at: [indexPath], with: .fade)
    //     } else if editingStyle == .insert {
    //     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    //     }
    //     }
    
    
    override func viewWillAppear(_ animated: Bool) {
        // Get data from Core Data
        getData()
        
        //reload the TableView
        tableView.reloadData()
    }
    func getData(){
        // Store Core data
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        do{
            events = try context.fetch(Event.fetchRequest())
            print(events.count)
        }catch{
            print("Fetch of Data Failed")
        }
        
    }
    
    /*
     * Actions
     */
    @IBAction func cancelButtonPressed(segue: UIStoryboardSegue){
        print("cancel")
    }
    @IBAction func doneButtonPressed(segue: UIStoryboardSegue){
        let vc = segue.source as! NewEventTableViewController
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let eventEntity = NSEntityDescription.entity(forEntityName: "Event", in: context)
        let _ = NSManagedObject(entity: eventEntity!, insertInto: context)
        let event = Event(context: context)
        
        
        
        
        print("Adding Compentition Name")
        //event.setValue(vc.competitionNameTextField.text, forKey: "competitionName")
        event.competitionName = vc.competitionNameTextField.text
        print("Adding CompetitionNumber")
        //event.setValue(vc.competitionNumberTextField.text, forKey: "competitionNumber")
        event.competitionNumber = vc.competitionNumberTextField.text
        print("Adding Season")
        //event.setValue(vc.seasonSegmentControl.titleForSegment(at: vc.seasonSegmentControl.selectedSegmentIndex)! as String, forKey: "season")
        event.season = vc.seasonSegmentControl.titleForSegment(at: vc.seasonSegmentControl.selectedSegmentIndex)! as String
        print("Adding DateTime")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy hh:mm aa"
        //event.setValue(dateFormatter.date(from: vc.dateTimeTextField.text!) , forKey: "eventDateTime")
        event.eventDateTime = dateFormatter.date(from: vc.dateTimeTextField.text!) as NSDate?
        print("Adding Gender")
        //event.setValue(vc.genderSegmentControl.titleForSegment(at: vc.genderSegmentControl.selectedSegmentIndex)! as String, forKey: "gender")
        event.gender = vc.genderSegmentControl.titleForSegment(at: vc.genderSegmentControl.selectedSegmentIndex)! as String
        print("Adding Event Type")
        //event.setValue(vc.eventTypeTextField.text, forKey: "eventType")
        event.eventType = vc.eventTypeTextField.text
        print("Adding Measurement")
        //event.setValue(vc.measureSegmentControl.titleForSegment(at: vc.measureSegmentControl.selectedSegmentIndex), forKey: "measurement")
        event.measurement = vc.measureSegmentControl.titleForSegment(at: vc.measureSegmentControl.selectedSegmentIndex)
        print("Adding Number of Flights")
        //event.setValue(Int(vc.flightNumberTextField.text!), forKey: "numberOfFlights")
        event.numberOfFlights = Int16(vc.flightNumberTextField.text!)!
        print("Adding Athletes In Final")
        //event.setValue(Int(vc.finalAthleteNumberTextField.text!), forKey: "athletesInFinal")
        event.athletesInFinal = Int16(vc.finalAthleteNumberTextField.text!)!
        print("Adding Auto Mark")
        //event.setValue(Float(vc.autoMarkTextField.text!), forKey: "automaticMark")
        event.automaticMark = Float(vc.autoMarkTextField.text!)!
        print("Adding Provo Mark")
        //event.setValue(Float(vc.provoMarkTextField.text!), forKey: "provisionalMark")
        event.provisionalMark = Float(vc.provoMarkTextField.text!)!
        print("Adding Flight Info")
        
        for flight in vc.flights {
            let newFlight = Flight(context: context)
            for athlete in flight {
                newFlight.addToAthletes(athlete)
            }
            event.addToFlights(newFlight)
        }
        
        //event.setValue(thing, forKey: "flights")
        
        
        // Save the date to core data
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        events.append(event)
        print("Done")
    }
    
}

