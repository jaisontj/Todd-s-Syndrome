//
//  NewPatientModel.swift
//  ToddsSyndrome
//
//  Created by Jaison Titus on 28/08/16.
//  Copyright © 2016 jaison. All rights reserved.
//

import Foundation

class PatientModel {
    //Personal Details
    var name: String?
    var dob: String?
    var gender: String?
    
    //Other Specific Details
    var hallucinogens: Bool?
    var migraines: Bool?
    
    init() {
        
    }
    
    init(realmPatientDetails: RealmPatientModel) {
        self.name = realmPatientDetails.name
        self.dob = realmPatientDetails.dob
        self.gender = realmPatientDetails.gender
        self.migraines = realmPatientDetails.migraines.value
        self.hallucinogens = realmPatientDetails.hallucinogens.value
    }
    
    var age: Int? {
        get {
            let ageComponents = NSCalendar.currentCalendar().components(.Year,fromDate: getDateFromDobString(),toDate: NSDate(),options: [])
            return ageComponents.year
        }
    }
    
    func getNumberOfRequiredFactors() -> Int {
        return 5
    }
    
    func getWeightForFactor() -> Int {
        return 100/(getNumberOfRequiredFactors() - 1)
    }
    
    private func getDateFromDobString() -> NSDate {
        let timeFormatter = NSDateFormatter()
        timeFormatter.dateStyle = .LongStyle
        timeFormatter.timeStyle = .NoStyle
        return timeFormatter.dateFromString(dob!)!
    }
    
    func getChancesOfToddsSyndrome() -> Int {
        var chances = 0
        
        if (migraines!) {
            chances += getWeightForFactor()
        }
        
        if (age <= 15) {
            chances += getWeightForFactor()
        }
        
        if (gender! == Gender.MALE.rawValue) {
            chances += getWeightForFactor()
        }
        
        if (hallucinogens!) {
            chances += getWeightForFactor()
        }
        
        return chances
        
    }
    
}
