//
//  HistoryViewController.swift
//  FlickrSearch
//
//  Created by Preema DSouza on 11/10/2020.
//  Copyright © 2020 Preema DSouza. All rights reserved.
//

import UIKit

// protocol to send the selected history search term to corresponding view controller
protocol HistoryViewControllerDelegate: AnyObject {
    func selectedSearchTerm(text: String)
}

class HistoryViewController: UIViewController {
    @IBOutlet weak var historyTableView: UITableView!
    
    weak var delegate: HistoryViewControllerDelegate?
    
    var viewModel: HistoryViewModel! {
        didSet {
            historyTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = HistoryViewModel()
    }
    
}

// MARK: - TableView data source and  delegate

extension HistoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfSearchTerms
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = viewModel.searchTerm(for: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.popViewController(animated: true)
        delegate?.selectedSearchTerm(text: viewModel.searchTerm(for: indexPath.row))
    }
    
}
