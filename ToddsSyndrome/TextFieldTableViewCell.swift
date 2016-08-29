//
//  TextFieldTableViewCell.swift
//  ToddsSyndrome
//
//  Created by Jaison Titus on 28/08/16.
//  Copyright © 2016 jaison. All rights reserved.
//

import UIKit

protocol TextFieldTableViewCellDelegate {
    func onTextFieldEdited(editedText: String?,factorType: FactorType)
}

class TextFieldTableViewCell: FactorCell, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    var delegate: TextFieldTableViewCellDelegate?

    override func setUpCell() {
        //check type and set the corresponding placeholder and listeners
        switch factorType! {
        case .NAME:
            setTextFieldPlaceholder("Name")
            break
        case .DOB:
            setTextFieldPlaceholder("Date Of Birth")
            setInputTypeToDatePicker()
            break
        default: return
        }
        
        //Listener on the TextField
        textField.delegate = self
    }
    
    private func setInputTypeToDatePicker() {
        let datePickerView  : UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.Date
        textField.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(TextFieldTableViewCell.handleDatePicker(_:)), forControlEvents: UIControlEvents.ValueChanged)
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.Default
        toolBar.translucent = true
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(TextFieldTableViewCell.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(TextFieldTableViewCell.cancelPicker))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.userInteractionEnabled = true
        
        textField.inputAccessoryView = toolBar
    }
    
    func donePicker() {
        if textField.text!.isEmpty {
            setDateToTextField(NSDate())
        }
        
        self.textField.endEditing(true)
    }
    
    func cancelPicker() {
        self.textField.endEditing(true)
    }
    
    func handleDatePicker(sender: UIDatePicker) {
        setDateToTextField(sender.date)
    }
    
    private func setDateToTextField(date: NSDate) {
        let timeFormatter = NSDateFormatter()
        timeFormatter.dateStyle = .LongStyle
        timeFormatter.timeStyle = .NoStyle
        textField.text = timeFormatter.stringFromDate(date)
    }
    
    func setTextFieldPlaceholder(placeHolder: String) {
        textField.placeholder = placeHolder
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if let delegate = self.delegate {
            delegate.onTextFieldEdited(textField.text, factorType: factorType!)
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.textField.endEditing(true)
        return true
    }
    
    override func turnErrorModeOn() {
        print("Error Mode on for \(factorType!)")
    }

}
