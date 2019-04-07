//
//  SectionedDetailListViewController.swift
//  SwiftNest iOS
//
//  Created by David House on 4/5/19.
//  Copyright © 2019 repairward. All rights reserved.
//

import UIKit

public protocol SectionedDetailListViewModelConsumer: ViewModelConsumer {
    var delegate: SectionedDetailListDelegate? { get set }
    var viewModel: SectionedDetailListViewModel { get set }
    static func create() -> SectionedDetailListViewModelConsumer?
}

class SectionedDetailListViewController: UITableViewController, SectionedDetailListViewModelConsumer {
    
    weak var delegate: SectionedDetailListDelegate?
    
    var viewModel: SectionedDetailListViewModel = SectionedDetailListViewModel.emptyViewModel() {
        didSet {
            DispatchQueue.main.async {
                self.title = self.viewModel.title
                self.tableView.reloadData()
            }
        }
    }
    
    static func create() -> SectionedDetailListViewModelConsumer? {
        let storyboard = UIStoryboard(name: "SectionedDetailList", bundle: Bundle(for: SectionedDetailListViewController.self))
        guard let navController = storyboard.instantiateInitialViewController() as? UINavigationController, let viewController = navController.topViewController as? SectionedDetailListViewController else {
            return nil
        }
        return viewController
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sections[section].details.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionLabel = UILabel()
        sectionLabel.text = viewModel.sections[section].title
        return sectionLabel
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath)
        let section = viewModel.sections[indexPath.section]
        let detail = section.details[indexPath.row]
        cell.textLabel?.text = detail.title
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.text = detail.subtitle
        cell.detailTextLabel?.numberOfLines = 0
        return cell
    }
}
