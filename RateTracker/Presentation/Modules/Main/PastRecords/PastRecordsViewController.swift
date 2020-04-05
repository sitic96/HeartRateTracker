//
//  PastRecordsViewController.swift
//  RateTracker
//
//  Created by Sitora on 30/01/2020.
//  Copyright © 2020 Sitora Guliamova. All rights reserved.
//

import UIKit

class PastRecordsViewController: UIViewController {
    
    var viewModel: PastRecordsViewModelProtocol!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }
}

extension PastRecordsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.recordsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecordViewCell.identifier) as? RecordViewCell else {
            return UITableViewCell()
        }
        cell.title = viewModel.records[indexPath.row].name ?? "\(indexPath.row)"
        return cell
    }
}
