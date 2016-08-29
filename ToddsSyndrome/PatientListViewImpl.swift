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
    func showProgressIndicator()
    func hideProgressIndicator()
}

class PatientListViewImpl: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var refreshControl: UIRefreshControl!
    var presenter: PatientListPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Adding refresh control 
        addRefreshControl()
        
        self.presenter = PatientListPresenterImpl(view: self)

        //Intializing the tableview
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    private func addRefreshControl() {
        self.refreshControl = UIRefreshControl()
        self.refreshControl.addTarget(self, action: #selector(PatientListViewImpl.refreshData), forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
    }
    
    func refreshData() {
        self.refreshControl.endRefreshing()
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
    
}

extension PatientListViewImpl: PatientListView {
    
    func reloadTableView() {
        tableView.reloadData()
        tableView.hidden = false
    }
    
    func showEmptyView() {
        let messageLabel = UILabel()
        messageLabel.frame = CGRectMake(0.0, 0.0, self.view.bounds.size.width, self.view.bounds.size.height)
        messageLabel.text = "Looks like you have no patients saved, start by clicking on + button"
        messageLabel.textAlignment = NSTextAlignment.Center
        messageLabel.textColor = UIColor.grayColor()
        messageLabel.numberOfLines = 0
        messageLabel.backgroundColor = UIColor.clearColor()
        messageLabel.font = UIFont(name: "Helvetica", size: 25)
        view.addSubview(messageLabel)
        
        //Hide table v
        tableView.hidden = true
    }
    
    func showProgressIndicator() {
        self.refreshControl.beginRefreshing()
    }
    
    func hideProgressIndicator() {
        self.refreshControl.endRefreshing()
    }

}