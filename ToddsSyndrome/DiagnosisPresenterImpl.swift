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
        guard let _ = patientModel.name else {
            view.showErrorAtSection(0)
            showErrorForFactorCell(FactorType.NAME)
            return
        }
        
        if patientModel.name!.isEmpty {
            view.showErrorAtSection(0)
            showErrorForFactorCell(FactorType.NAME)
            return
        }
        
        guard let _ = patientModel.dob else {
            view.showErrorAtSection(1)
            showErrorForFactorCell(FactorType.DOB)
            return
        }
        
        guard let _ = patientModel.gender else {
            view.showErrorAtSection(2)
            showErrorForFactorCell(FactorType.GENDER)
            return
        }
        
        guard let _ = patientModel.migranes else {
            view.showErrorAtSection(3)
            showErrorForFactorCell(FactorType.MIGRANE)
            return
        }
        
        guard let _ = patientModel.hallucinogens else {
            view.showErrorAtSection(4)
            showErrorForFactorCell(FactorType.HALLUCINOGENS)
            return
        }
        
        //If we are here, it means the form is valid
        
        //Save data to local storage 
        PatientListDataStoreImpl().saveNewPatient(patientModel)
        
        //Show Todds Syndrome , likely percentage 
        
        
        //Dismiss VC
        view.showToddsSyndromeAlert(patientModel.name!, percentage: patientModel.getChancesOfToddsSyndrome())
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
