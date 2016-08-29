//
//  RealmPatientModel.swift
//  ToddsSyndrome
//
//  Created by Jaison Titus on 29/08/16.
//  Copyright © 2016 jaison. All rights reserved.
//

import Foundation
import RealmSwift

class RealmPatientModel: Object {
    
    dynamic var name: String?
    dynamic var dob: String?
    dynamic var gender: String?
    
    var hallucinogens = RealmOptional<Bool>()
    var migraines = RealmOptional<Bool>()
    
    func setData(patientModel: PatientModel) {
        name = patientModel.name
        dob = patientModel.dob
        gender = patientModel.gender
        hallucinogens.value = patientModel.hallucinogens
        migraines.value = patientModel.migraines
    }
}
