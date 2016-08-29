//
//  DiagnosisPresenterImpl.swift
//  ToddsSyndrome
//
//  Created by Jaison Titus on 28/08/16.
//  Copyright © 2016 jaison. All rights reserved.
//

import Foundation
import UIKit

protocol DiagnosisPresenter {
    func getNumberOfSections() -> Int
    func getNumberOfRows(section: Int) -> Int
    func getCellForRowAtIndexPath(tableView: UITableView,indexPath: NSIndexPath) -> UITableViewCell
    func getTitleForSectionHeader(section: Int) -> String
    func onSubmitButtonClicked()
}


class DiagnosisPresenterImpl: DiagnosisPresenter,TextFieldTableViewCellDelegate,TwoButtonTableViewCellDelegate {
    
    var view: DiagnosisView!
    var patientModel: PatientModel!
    var factorCells = [FactorCell]()
    
    init(view: DiagnosisView) {
        self.view = view
        self.patientModel = PatientModel()
    }
    
    //Mark:- UITableViewController
    func getNumberOfSections() -> Int {
        return patientModel.getNumberOfRequiredFactors()
    }
    
    func getTitleForSectionHeader(section: Int) -> String {
        switch section {
        case 0: return "Name"
        case 1: return "Date of Birth"
        case 2: return "Gender"
        case 3: return "Migranes"
        case 4: return "Hallucinogens"
        default: return ""
        }
    }
    
    func getNumberOfRows(section: Int) -> Int {
        return 1
    }
    
    func getCellForRowAtIndexPath(tableView: UITableView,indexPath: NSIndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier(FormCellIdentifiers.TEXTFIELDCELL) as! TextFieldTableViewCell
            cell.delegate = self
            cell.factorType = FactorType.NAME
            factorCells.append(cell)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier(FormCellIdentifiers.TEXTFIELDCELL) as! TextFieldTableViewCell
            cell.delegate = self
            cell.factorType = FactorType.DOB
            factorCells.append(cell)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCellWithIdentifier(FormCellIdentifiers.TWOBUTTONCELL) as! TwoButtonTableViewCell
            cell.delegate = self
            cell.factorType = FactorType.GENDER
            factorCells.append(cell)
            return cell
        case 3:
            let cell = tableView.dequeueReusableCellWithIdentifier(FormCellIdentifiers.TWOBUTTONCELL) as! TwoButtonTableViewCell
            cell.delegate = self
            cell.factorType = FactorType.MIGRANE
            factorCells.append(cell)
            return cell
        case 4:
            let cell = tableView.dequeueReusableCellWithIdentifier(FormCellIdentifiers.TWOBUTTONCELL) as! TwoButtonTableViewCell
            cell.delegate = self
            cell.factorType = FactorType.HALLUCINOGENS
            factorCells.append(cell)
            return cell
        default:
            fatalError("Extra factor added in NewPatientModel but not accounted for in GetCellForRowAtIndexPath")
        }
    }
    
    
    //MARK:- View Actions
    
    func onSubmitButtonClicked() {
        //Check if the required fields are entered
        let formValidity = checkForm(patientModel)
        if let index = formValidity.index {
            view.showFormInvalidAlert("Incomplete Form", message: "All details are mandatory. You have missed out on \(formValidity.factorType!.rawValue)",handler: { (action) in
                self.view.showErrorAtSection(index)
                self.showErrorForFactorCell(formValidity.factorType!)
            })
            return
        }
        
        //Save data to local storage
        PatientListDataStoreImpl().saveNewPatient(patientModel)
        
        //Show Todds Syndrome , likely percentage
        view.showToddsSyndromeAlert(patientModel.name!, percentage: patientModel.getChancesOfToddsSyndrome())
    }
    
    //(nil,nil) is returned is it is valid
    func checkForm(patientModel: PatientModel) -> (index: Int?, factorType: FactorType?) {
        guard let _ = patientModel.name else {
            return (0,.NAME)
        }
        
        if patientModel.name!.isEmpty {
            return (0,.NAME)
        }
        
        guard let _ = patientModel.dob else {
            return (1,.DOB)
        }
        
        if patientModel.dob!.isEmpty {
            return (1,.DOB)
        }
        
        guard let _ = patientModel.gender else {
            return (2,.GENDER)
        }
        
        guard let _ = patientModel.migranes else {
            return (3,.MIGRANE)
        }
        
        guard let _ = patientModel.hallucinogens else {
            return (4,.HALLUCINOGENS)
        }
        
        return (nil,nil)
    }
    
    func showErrorForFactorCell(factorType: FactorType) {
        for factorCell in factorCells {
            if (factorCell.factorType == factorType) {
                factorCell.turnErrorModeOn()
                break
            }
        }
    }
    
    //MARK:- TextFieldTableViewCellDelegate
    func onTextFieldEdited(editedText: String?, factorType: FactorType) {
        switch factorType {
        case .NAME:
            patientModel.name = editedText
            break
        case .DOB:
            patientModel.dob = editedText
            break
        default:
            break
        }
    }
    
    //MARK:- TwoButtonTableViewCellDelegate
    func onButtonSelected(selectedLabelString: String, factorType: FactorType) {
        switch factorType {
        case .GENDER:
            patientModel.gender = selectedLabelString
            break
        case .MIGRANE:
            patientModel.migranes = getBoolFromString(selectedLabelString)
            break
        case .HALLUCINOGENS:
            patientModel.hallucinogens = getBoolFromString(selectedLabelString)
            break
        default:
            break
        }
    }
    
    //func which returns a true for "Yes" and a false for "No"
    func getBoolFromString(string: String) -> Bool {
        return string == "Yes" ? true : false
    }
    
    
}
