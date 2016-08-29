//
//  PatientListDataStore.swift
//  ToddsSyndrome
//
//  Created by Jaison Titus on 29/08/16.
//  Copyright © 2016 jaison. All rights reserved.
//

import Foundation
import RealmSwift

protocol PatientListDataStoreListener {
    func onSavedPatientDetailsArrived(patientList: [PatientModel])
}

protocol PatientListDataStore {
    func getSavedPatients(listener : PatientListDataStoreListener)
    func saveNewPatient(patientModel: PatientModel)
}

class PatientListDataStoreImpl: PatientListDataStore {
    
    // Get the default Realm
    let realm = try! Realm()
    
    func getSavedPatients(listener : PatientListDataStoreListener){
        let realmPatients = realm.objects(RealmPatientModel.self)
        var patients = [PatientModel]()
        
        for realmPatient in realmPatients {
            patients.append(PatientModel(realmPatientDetails: realmPatient))
        }
        
        //Last saved to first saved
        patients = patients.reverse()
        
        listener.onSavedPatientDetailsArrived(patients)
    }
    
    func saveNewPatient(patientModel: PatientModel) {
        let newPatient = RealmPatientModel()
        newPatient.setData(patientModel)
        
        try! realm.write {
            realm.add(newPatient)
        }
    }
    
}