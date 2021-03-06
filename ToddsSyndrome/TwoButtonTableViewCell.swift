//
//  TwoButtonTableViewCell.swift
//  ToddsSyndrome
//
//  Created by Jaison Titus on 29/08/16.
//  Copyright © 2016 jaison. All rights reserved.
//

import UIKit

protocol TwoButtonTableViewCellDelegate {
    func onButtonSelected(selectedLabelString: String, factorType: FactorType)
}

class TwoButtonTableViewCell: FactorCell {
    
    var delegate: TwoButtonTableViewCellDelegate?

    //Left
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var label1: UILabel!
    
    //Right
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var label2: UILabel!
    
    override func awakeFromNib() {
        setButtonBackground(button1)
        setButtonBackground(button2)
    }
    
    override func setUpCell() {
        switch factorType! {
        case .GENDER:
            setLabelName(Gender.MALE.rawValue, label2Text: Gender.FEMALE.rawValue)
            break
        case .MIGRANE:
            setLabelName("Yes", label2Text: "No")
            break
        case .HALLUCINOGENS:
            setLabelName("Yes", label2Text: "No")
            break
        default:
            break
        }
    }
    
    @IBAction func button1Clicked(sender: UIButton) {
        if let delegate = self.delegate {
            delegate.onButtonSelected(label1.text!,factorType: factorType!)
        }
        button1.selected = true
        button2.selected = false
    }
    
    @IBAction func button2Clicked(sender: UIButton) {
        if let delegate = self.delegate {
            delegate.onButtonSelected(label2.text!,factorType: factorType!)
        }
        button1.selected = false
        button2.selected = true
    }
    
    func setButtonBackground(button: UIButton) {
        button.setImage(UIImage(named: "checkedBox"), forState: UIControlState.Selected)
        button.setImage(UIImage(named: "uncheckedBox"), forState: UIControlState.Normal)
    }
    
    func setLabelName(label1Text: String, label2Text: String) {
        label1.text = label1Text
        label2.text = label2Text
    }
    
    override func turnErrorModeOn() {
        print("Error Mode on for \(factorType!)")
    }

}
