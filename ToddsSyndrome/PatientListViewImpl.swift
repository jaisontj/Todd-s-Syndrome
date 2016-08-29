//
//  PatientListViewImplViewController.swift
//  ToddsSyndrome
//
//  Created by Jaison Titus on 29/08/16.
//  Copyright © 2016 jaison. All rights reserved.
//

import UIKit

protocol PatientListView {
    func reloadTableView()
    func showEmptyView()
    func hideEmptyView()
    func navigateToPatientDetailsView(patientDetails: PatientModel)
}

class PatientListViewImpl: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let messageLabel = UILabel()
    
    var presenter: PatientListPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter = PatientListPresenterImpl(view: self)

        //Intializing the tableview
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        presenter.viewDidAppear()
    }
}

extension PatientListViewImpl: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getNumberOfRows()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return presenter.getCellForRow(tableView, indexPath: indexPath)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        presenter.didSelectRow(indexPath)
    }
    
}

extension PatientListViewImpl: PatientListView {
    
    func reloadTableView() {
        tableView.reloadData()
        tableView.hidden = false
    }
    
    func hideEmptyView() {
        messageLabel.removeFromSuperview()
    }
    
    func showEmptyView() {
        messageLabel.frame = CGRectMake(0.0, 0.0, self.view.bounds.size.width, self.view.bounds.size.height)
        messageLabel.text = "Looks like you have no patients saved, start by clicking on the + button"
        messageLabel.textAlignment = NSTextAlignment.Center
        messageLabel.textColor = UIColor.grayColor()
        messageLabel.numberOfLines = 0
        messageLabel.backgroundColor = UIColor.clearColor()
        messageLabel.font = UIFont(name: "Helvetica", size: 20)
        view.addSubview(messageLabel)
        
        //Hide table view
        tableView.hidden = true
    }
    
    func navigateToPatientDetailsView(patientDetails: PatientModel) {
        self.performSegueWithIdentifier(SegueIdentifiers.PATIENTDETAILS, sender: patientDetails)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let patientDetails = sender as? PatientModel {
            if let destinationVC = segue.destinationViewController as? PatientDetailsViewImpl {
                destinationVC.patientDetails = patientDetails
            }
        }
    }

}