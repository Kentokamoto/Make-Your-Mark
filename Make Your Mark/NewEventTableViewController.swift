//
//  NewEventTableViewController.swift
//  Make Your Mark
//
//  Created by Kento Okamoto on 11/21/16.
//  Copyright © 2016 Kento Okamoto. All rights reserved.
//

import UIKit

class NewEventTableViewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    /*
     * Outlet Variables
     */
    @IBOutlet weak var competitionNameTextField: UITextField!
    @IBOutlet weak var competitionNumberTextField: UITextField!
    @IBOutlet weak var seasonSegmentControl: UISegmentedControl!
    @IBOutlet weak var dateTimeTextField: UITextField!
    @IBOutlet weak var genderSegmentControl: UISegmentedControl!
    @IBOutlet weak var eventTypeTextField: UITextField!
    @IBOutlet weak var measureSegmentControl: UISegmentedControl!
    @IBOutlet weak var flightNumberTextField: UITextField!
    @IBOutlet weak var finalAthleteNumberTextField: UITextField!
    @IBOutlet weak var provoMarkTextField: UITextField!
    @IBOutlet weak var autoMarkTextField: UITextField!
    /*
     * Variables
     */
    let eventList = ["Discus","Hammer","High Jump" , "Javelin", "Long Jump", "Pole Vault", "Shot Put", "Triple Jump", "Weight Throw" ]
    
    var flights = [FlightModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // Sets the events view to a picker
        let pickerView = UIPickerView()
        pickerView.delegate = self
        eventTypeTextField.inputView = pickerView
        
        let item : UITextInputAssistantItem = eventTypeTextField.inputAssistantItem
        item.leadingBarButtonGroups = []
        item.trailingBarButtonGroups = []
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }
    
    /*
     * Picker View Components
     */
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return eventList.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return eventList[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        eventTypeTextField.text = eventList[row]
    }

    /*
     * Date Picker View Components
     */
    @IBAction func dateTextFieldEditing(_ sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.dateAndTime
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(NewEventTableViewController.datePickerValueChanged ), for: UIControlEvents.valueChanged)
    }
    func datePickerValueChanged(sender: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.medium
        dateTimeTextField.text = dateFormatter.string(from: sender.date)
        
        
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if( indexPath.section < 1){
            tableView.deselectRow(at: indexPath, animated: false)
        }
    }
    
    
    
    /*
     * Prepare for Segue
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "doneButtonSegue"{
                print("Lets Save")
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            let event = Event(context: context)
            event.competitionName = competitionNameTextField.text
            event.competitionNumber = competitionNumberTextField.text
            event.season = seasonSegmentControl.titleForSegment(at: seasonSegmentControl.selectedSegmentIndex)
            //event.eventDateTime = Date(dateTimeTextField.text)
            event.gender = genderSegmentControl.titleForSegment(at: genderSegmentControl.selectedSegmentIndex)
            event.eventType = eventTypeTextField.text
            event.measurement = measureSegmentControl.titleForSegment(at: measureSegmentControl.selectedSegmentIndex)
            //event.numberOfFlights = flightNumberTextField.text
            //event.athletesInFinal = finalAthleteNumberTextField.text
            //event.automaticMark = autoMarkTextField.text
            //event.provisionalMark = provoMarkTextField.text
            
            
            // Save the data to core data
            (UIApplication.shared.delegate as! AppDelegate ).saveContext()
            
        }else if segue.identifier == "addAthleteSegue" {
            print("Prepare for Athlete adding")
            if flights.isEmpty{
                print("Creating")
                createFlights(numFlights: Int(flightNumberTextField.text!)!)
            }
            let vc = segue.destination as! AthleteTableViewController
            if let title = flightNumberTextField.text, !title.isEmpty  {
                vc.flights = self.flights
            }
        }
    }
    
    func createFlights(numFlights : Int){
        var tempflights = [FlightModel]()
        for i in  1 ... numFlights{
            var tempAthlete = [AthleteModel]()
            for j in 1...9{
                tempAthlete.append(AthleteModel(pos: j))
            }
            let tempFlight = FlightModel(flightNum: i,athletes: tempAthlete)
            tempflights.append(tempFlight)
        }
        self.flights = tempflights
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "doneButtonSegue" {
            print(finalAthleteNumberTextField.text!)
            if(competitionNameTextField.text == ""){
                let alert = UIAlertController(title: "Competition Name Missing", message: "Please enter a competition name in the event before continuing", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)

                return false
            }
            if(dateTimeTextField.text == ""){
                let alert = UIAlertController(title: "Competition Date Missing", message: "Please enter a competition date in the event before continuing", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)

                return false
            }
            if(eventTypeTextField.text == ""){
                let alert = UIAlertController(title: "Event Type Missing", message: "Please enter an event type in the event before continuing", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)

                return false
            }
            if(flightNumberTextField.text == ""){
                let alert = UIAlertController(title: "Number of Flights Missing", message: "Please enter the number of flights in the event before continuing", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)

                return false
            }
            if(finalAthleteNumberTextField.text! == "" && Int((flightNumberTextField.text)!)!  > 1){
                let alert = UIAlertController(title: "Athletes in Final Missing", message: "Please enter the number of athletes in finals in the event before continuing", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)

                return false
            }
            
            
        }else if identifier == "addAthleteSegue" {
            print("Adding Athletes")
            if flightNumberTextField.text == ""{
                let alert = UIAlertController(title: "Number of Flights not Specified", message: "Please enter the number of flights in the event before continuing", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return false
            }
        }
        return true
    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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