//
//  PatientDetailsViewImpl.swift
//  ToddsSyndrome
//
//  Created by Jaison Titus on 29/08/16.
//  Copyright © 2016 jaison. All rights reserved.
//

import UIKit

class PatientDetailsViewImpl: UITableViewController {
    
    var patientDetails: PatientModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return patientDetails.getNumberOfRequiredFactors() + 1 // add another row to show the percentage
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(PatientDetailsCellIdentifiers.DETAILCELL, forIndexPath: indexPath) as UITableViewCell
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Name"
            cell.detailTextLabel?.text = patientDetails.name
            break
        case 1:
            cell.textLabel?.text = "Age"
            cell.detailTextLabel?.text = "\(patientDetails.age!)"
            break
        case 2:
            cell.textLabel?.text = "Gender"
            cell.detailTextLabel?.text = patientDetails.gender
            break
        case 3:
            cell.textLabel?.text = "Migranes"
            cell.detailTextLabel?.text = patientDetails.migranes! ? "Yes" : "No"
            break
        case 4:
            cell.textLabel?.text = "Hallucinogens"
            cell.detailTextLabel?.text = patientDetails.hallucinogens! ? "Yes" : "No"
            break
        case 5:
            cell.textLabel?.text = "Chances of Todd's Syndrome(%)"
            cell.detailTextLabel?.text = "\(patientDetails.getChancesOfToddsSyndrome())"
            break
        default: break
        }
        
        return cell
    }
    
}
