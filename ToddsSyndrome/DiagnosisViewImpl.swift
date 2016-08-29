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
    func dismissView()
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
        self.dismissViewControllerAnimated(true, completion: nil)
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
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
