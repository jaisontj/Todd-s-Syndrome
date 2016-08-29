//
//  PatientListPresenter.swift
//  ToddsSyndrome
//
//  Created by Jaison Titus on 29/08/16.
//  Copyright © 2016 jaison. All rights reserved.
//

import Foundation
import UIKit

protocol PatientListPresenter {
    func getNumberOfRows() -> Int
    func getCellForRow(tableView: UITableView,indexPath: NSIndexPath) -> UITableViewCell
    func viewDidAppear()
    func didSelectRow(indexpath: NSIndexPath)
}

class PatientListPresenterImpl: PatientListPresenter, PatientListDataStoreListener {
    
    var view: PatientListView!
    var dataStore: PatientListDataStore!
    var patientList = [PatientModel]()
    
    init(view: PatientListView) {
        self.view = view
        self.dataStore = PatientListDataStoreImpl()
    }
    
    func viewDidAppear() {
        dataStore.getSavedPatients(self)
    }
    
    //MARK: - UITableView Methods
    
    func getNumberOfRows() -> Int {
        return patientList.count
    }
    
    func getCellForRow(tableView: UITableView,indexPath: NSIndexPath) -> UITableViewCell {
        let patientModel = patientList[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier(PatientListCellIdentifiers.CELL)
        cell?.textLabel?.text = patientModel.name        
        return cell!
    }
    
    func didSelectRow(indexpath: NSIndexPath) {
        view.navigateToPatientDetailsView(patientList[indexpath.row])
    }
    
    //MARK: - DATA STORE
    
    func onSavedPatientDetailsArrived(patientList: [PatientModel]) {
        self.patientList = patientList
        view.reloadTableView()
        //Check if empty
        if patientList.count == 0 {
            view.showEmptyView()
        }
        
    }
}