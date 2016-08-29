//
//  PatientListDataStore.swift
//  ToddsSyndrome
//
//  Created by Jaison Titus on 29/08/16.
//  Copyright © 2016 jaison. All rights reserved.
//

import Foundation

protocol PatientListDataStoreListener {
    func onSavedPatientDetailsArrived(patientList: [PatientModel])
}

protocol PatientListDataStore {
    func getSavedPatients()
}

class PatientListDataStoreImpl: PatientListDataStore {
    
    var listener : PatientListDataStoreListener!
    
    init(listener: PatientListDataStoreListener) {
        self.listener = listener
    }
    
    func getSavedPatients(){
        listener!.onSavedPatientDetailsArrived([])
    }
    
}