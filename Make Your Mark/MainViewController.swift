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
        cell.competitionNameLabel?.text = event.competitionName
        //cell.dateLabel?.text = formatter.string(from: (event.eventDateTime as? Date)!)
        cell.eventTypeLabel?.text = event.eventType
        cell.genderLabel?.text = event.gender
        
        return cell
    }
    
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
        print("Done")
    }
    
}

