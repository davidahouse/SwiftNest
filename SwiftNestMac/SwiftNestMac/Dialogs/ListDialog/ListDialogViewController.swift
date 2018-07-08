//
//  ListDialogViewController.swift
//
//  Created by davidahouse on 5/28/18.
//  Copyright © 2018 davidahouse. All rights reserved.
//

import AppKit

protocol ListDialogViewControllerDelegate: class {
    func okSelected()
}

class ListDialogViewController: NSViewController {
    
    @IBOutlet var tableView: NSTableView!
    weak var delegate: ListDialogViewControllerDelegate?

    var model: Listable? {
        didSet {
            setupTable()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.selectionHighlightStyle = .regular
        tableView.usesAlternatingRowBackgroundColors = true
    }
    
    private func setupTable() {
        
        guard let model = model else {
            return
        }
        
        tableView.columnAutoresizingStyle = .uniformColumnAutoresizingStyle
        tableView.removeTableColumn(tableView.tableColumns[0])
        for i in 1...model.numberOfColumns() {
            
            let column = NSTableColumn(identifier: NSUserInterfaceItemIdentifier(rawValue: "\(i)"))
            column.title = model.columnName(column: i)
            column.width = view.frame.width / CGFloat(model.numberOfColumns())
            column.isEditable = false
            tableView.addTableColumn(column)
        }
        tableView.sizeToFit()
        tableView.reloadData()
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
        tableView.sizeToFit()
    }
    
    @IBAction func okSelected(_ sender: Any) {
        delegate?.okSelected()
    }
}

extension ListDialogViewController: NSTableViewDataSource {

    func numberOfRows(in tableView: NSTableView) -> Int {
        
        return model?.numberOfRows() ?? 0
    }
}

extension ListDialogViewController: NSTableViewDelegate {
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "CellID"), owner: nil) as? NSTableCellView {
            if let identifier = tableColumn?.identifier.rawValue, let column = Int(identifier) {
                cell.textField?.stringValue = model?.valueAt(column: column, row: row) ?? ""
            } else {
                cell.textField?.stringValue = ""
            }
            cell.imageView?.image = nil
            return cell
        }
        return nil
    }
}
