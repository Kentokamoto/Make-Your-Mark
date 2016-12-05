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
        let entity = NSEntityDescription.entity(forEntityName: "Event", in: context)
        let item = NSManagedObject(entity: entity!, insertInto: context)
        //let event = Event(context: context)
        
        item.setValue(vc.competitionNameTextField.text, forKey: "competitionName")
        item.setValue(vc.competitionNumberTextField.text, forKey: "compeitionNumber")
        item.setValue(vc.seasonSegmentControl.titleForSegment(at: vc.seasonSegmentControl.selectedSegmentIndex), forKey: "season")
        item.setValue(vc.dateTimeTextField.text , forKey: "eventDateTime")
        item.setValue(vc.genderSegmentControl.titleForSegment(at: vc.genderSegmentControl.selectedSegmentIndex), forKey: "gender")
        item.setValue(vc.eventTypeTextField.text, forKey: "eventType")
        item.setValue(vc.measureSegmentControl.titleForSegment(at: vc.measureSegmentControl.selectedSegmentIndex), forKey: "measurement")
        item.setValue(vc.flightNumberTextField.text, forKey: "numberOfFlights")
        item.setValue(vc.finalAthleteNumberTextField.text, forKey: "athletesInFinal")
        item.setValue(vc.autoMarkTextField.text, forKey: "automaticMark")
        item.setValue(vc.provoMarkTextField.text, forKey: "provisionalMark")
        
//        event.setValue(vc.competitionNameTextField.text, forKey: "competitionName")
//        event.competitionNumber = vc.competitionNumberTextField.text
//        event.season = vc.seasonSegmentControl.titleForSegment(at: vc.seasonSegmentControl.selectedSegmentIndex)
//        //event.eventDateTime = Date(vc.dateTimeTextField.text)
//        event.gender = vc.genderSegmentControl.titleForSegment(at: vc.genderSegmentControl.selectedSegmentIndex)
//        event.eventType = vc.eventTypeTextField.text
//        event.measurement = vc.measureSegmentControl.titleForSegment(at: vc.measureSegmentControl.selectedSegmentIndex)
//        //event.numberOfFlights  = vc.flightNumberTextField.text
//        //event.athletesInFinal = vc.finalAthleteNumberTextField.text
//        //event.automaticMark = vc.autoMarkTextField.text
//        //event.provisionalMark = vc.provoMarkTextField.text
        
        // Save the date to core data
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        events.append(item as! Event)
        print("Done")
    }
    
}

