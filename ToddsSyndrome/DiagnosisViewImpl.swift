//
//  DiagnosisViewImpl.swift
//  ToddsSyndrome
//
//  Created by Jaison Titus on 28/08/16.
//  Copyright © 2016 jaison. All rights reserved.
//

import UIKit

protocol DiagnosisView {
    func showErrorAtSection(section: Int)
    func hideKeyboard()
    func showToddsSyndromeAlert(patientName: String,percentage: Int)
    func showFormInvalidAlert(title: String, message: String, handler: ((UIAlertAction) -> Void)?)
}

class DiagnosisViewImpl: UITableViewController {

    var presenter: DiagnosisPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = DiagnosisPresenterImpl(view: self)
    }
    
    //Mark:- UITableViewController

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return presenter.getNumberOfSections()
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return presenter.getTitleForSectionHeader(section)
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {        return presenter.getNumberOfRows(section)
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return presenter.getCellForRowAtIndexPath(tableView,indexPath: indexPath)
    }
    
    
    //MARK:- Submit button
    
    @IBAction func onSubmitButtonClicked(sender: UIBarButtonItem) {
        presenter.onSubmitButtonClicked()
    }

    @IBAction func onCancelButtonClicked(sender: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
}

extension DiagnosisViewImpl: DiagnosisView {
    
    func showErrorAtSection(section: Int) {
        tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 0,inSection: section), atScrollPosition: UITableViewScrollPosition.Top, animated: true)
    }
    
    func hideKeyboard() {
        view.endEditing(true)
    }
    
    func dismissView() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func showToddsSyndromeAlert(patientName: String,percentage: Int) {
        let message = "\(patientName) has a \(percentage)% chance of having Todds Syndrome"
        let alert = UIAlertController(title: "Diagnosis", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Cancel, handler: { (action) in
            self.dismissView()
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func showFormInvalidAlert(title: String, message: String, handler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Cancel, handler: handler))
        self.presentViewController(alert, animated: true, completion: nil)
    }
}
