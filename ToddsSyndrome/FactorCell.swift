//
//  FormCell.swift
//  ToddsSyndrome
//
//  Created by Jaison Titus on 29/08/16.
//  Copyright © 2016 jaison. All rights reserved.
//

import Foundation
import UIKit

class FactorCell: UITableViewCell {
    
    var factorType: FactorType? {
        didSet {
            setUpCell()
        }
    }
    
    func setUpCell() {
        fatalError("To use FactorCell, setUpCell MUST be overridden")
    }
    
    func turnErrorModeOn() {
        //Override 
    }
        
}
