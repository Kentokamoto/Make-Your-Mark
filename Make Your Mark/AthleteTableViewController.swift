//
//  AthleteTableViewController.swift
//  Make Your Mark
//
//  Created by Kento Okamoto on 11/21/16.
//  Copyright © 2016 Kento Okamoto. All rights reserved.
//

import UIKit

class AthleteTableViewController: UITableViewController, UINavigationControllerDelegate{
    var flights = [FlightModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        navigationController?.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return flights.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return flights[section].athletesInFlight.count
    }

    override func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        print("Editing Done")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "athleteIdentifier", for: indexPath) as! AthleteTableViewCell
        let athlete = flights[indexPath.section].athletesInFlight[indexPath.row]
        cell.positionLabel.text = String(describing: athlete.position!)
        cell.firstNameTextField.text = athlete.firstName
        cell.lastNameTextField.text = athlete.lastName
        cell.seedTextField.text = String(athlete.seedInMeters)
        return cell
    }
 
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Flight " + String(section + 1)
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if let controller = viewController as? NewEventTableViewController {
            print("Send me back")
            writeToModel()
            controller.flights = self.flights
        }
    }
    func writeToModel(){
        for i in 0...self.flights.count{
            
            for j in 0...self.flights[i].athletesInFlight.count {
                let path = IndexPath(row:j, section: i)
                let cell = tableView.dequeueReusableCell(withIdentifier: "athleteIdentifier", for: path ) as! AthleteTableViewCell
                
                self.flights[i].athletesInFlight[j].firstName = cell.firstNameTextField.text!
                self.flights[i].athletesInFlight[j].lastName = cell.lastNameTextField.text!
                self.flights[i].athletesInFlight[j].seedInMeters = Float(cell.seedTextField.text!)!
            }
            
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
