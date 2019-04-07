//
//  DetailListViewController.swift
//  SwiftNest iOS
//
//  Created by David House on 4/4/19.
//  Copyright © 2019 repairward. All rights reserved.
//

import UIKit

public protocol DetailListViewModelConsumer: ViewModelConsumer {
    var delegate: DetailListDelegate? { get set }
    var viewModel: DetailListViewModel { get set }
    static func create() -> DetailListViewModelConsumer?
}

class DetailListViewController: UITableViewController, DetailListViewModelConsumer {
    
    weak var delegate: DetailListDelegate?
    
    var viewModel: DetailListViewModel = DetailListViewModel.emptyViewModel() {
        didSet {
            DispatchQueue.main.async {
                self.title = self.viewModel.title
                self.tableView.reloadData()
            }
        }
    }

    static func create() -> DetailListViewModelConsumer? {
        let storyboard = UIStoryboard(name: "DetailList", bundle: Bundle(for: DetailListViewController.self))
        guard let navController = storyboard.instantiateInitialViewController() as? UINavigationController, let viewController = navController.topViewController as? DetailListViewController else {
            return nil
        }
        return viewController
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.details.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath)
        let detail = viewModel.details[indexPath.row]
        cell.textLabel?.text = detail.title
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.text = detail.subtitle
        cell.detailTextLabel?.numberOfLines = 0
        return cell
    }
}
