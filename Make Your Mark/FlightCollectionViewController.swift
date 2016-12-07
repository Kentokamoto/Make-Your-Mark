//
//  FlightCollectionViewController.swift
//  Make Your Mark
//
//  Created by Kento Okamoto on 12/6/16.
//  Copyright © 2016 Kento Okamoto. All rights reserved.
//

import UIKit

private let reuseIdentifier = "flightLogIdentifier"

protocol FlightCollectionViewControllerDelegate {
    func saveData(flight: Flight )
}

class FlightCollectionViewController: UICollectionViewController,UINavigationControllerDelegate {
    var flightLog : Flight?
    var delegate : FlightCollectionViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        self.automaticallyAdjustsScrollViewInsets = true
        navigationController?.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return (flightLog?.athletes?.count)!
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        let athlete = flightLog?.athletes?.object(at: section) as! Athlete
        let attempts = athlete.attempts as! NSArray
        return attempts.count + 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FlightCollectionViewCell
        let athlete = flightLog?.athletes?.object(at: indexPath.section) as! Athlete
        if indexPath.item == 0{
            cell.entryTextField.isHidden = true
            cell.label.text = athlete.lastName!  + ", " + athlete.firstName!
        }else{
            cell.label.isHidden = true
            cell.entryTextField.placeholder = "Attempt " + String(describing: indexPath.item)
            let attempts = athlete.attempts as! Array<Float>
            cell.entryTextField.text = String(describing: attempts[(indexPath.item)-1])
        }
    
        
        // Configure the cell
        return cell
    }

    @IBAction func attemptTextFieldEditEnd(_ sender: UITextField) {
        let path = sender.convert(CGPoint.zero, to: self.collectionView)
        let index = self.collectionView?.indexPathForItem(at: path)
        let currAthlete = flightLog?.athletes?.object(at: (index?.section)!) as! Athlete
        var attempts = currAthlete.attempts as! Array<Float>
        attempts[(index?.item)!-1] = Float(sender.text!)!
        currAthlete.attempts = attempts as NSArray
        flightLog?.insertIntoAthletes(currAthlete, at: (index?.section)!)
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if let _ = viewController as? EventDetailViewController {
            print("Beam me up")
            self.delegate?.saveData(flight: self.flightLog!)
        }
    }

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
