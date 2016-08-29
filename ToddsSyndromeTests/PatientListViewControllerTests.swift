//
//  PatientListViewControllerTests.swift
//  ToddsSyndrome
//
//  Created by Jaison Titus on 29/08/16.
//  Copyright © 2016 jaison. All rights reserved.
//

import XCTest
@testable import ToddsSyndrome
import RealmSwift
import UIKit

class PatientListViewControllerTests: XCTestCase {
    
    var viewController: PatientListViewImpl!
    
    override func setUp() {
        super.setUp()

        viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("patientsListViewController") as! PatientListViewImpl
    
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
}
