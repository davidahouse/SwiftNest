//
//  ListDialogViewController.swift
//
//  Created by davidahouse on 5/28/18.
//  Copyright © 2018 davidahouse. All rights reserved.
//

import AppKit

protocol ListDialogViewControllerDelegate: class {
    func okSelected()
    func cancelSelected()
    func itemSelected(identifier: String)
}

class ListDialogViewController: NSViewController {
    
    @IBOutlet var tableView: NSTableView!
    @IBOutlet var cancelButton: NSButton!
    
    weak var delegate: ListDialogViewControllerDelegate?

    var model: Listable? {
        didSet {
            setupTable()
        }
    }

    var allowCancel: Bool = true {
        didSet {
            self.cancelButton.isHidden = !allowCancel
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.selectionHighlightStyle = .regular
        tableView.usesAlternatingRowBackgroundColors = true
        cancelButton.isHidden = !allowCancel
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
    
    @IBAction func cancelSelected(_ sender: Any) {
        delegate?.cancelSelected()
    }

    @IBAction func tableViewDoubleClick(_ sender: Any) {
        let row = tableView.selectedRow
        if row >= 0 {
            if let identifier = model?.identifier(for: row) {
                delegate?.itemSelected(identifier: identifier)
                delegate?.okSelected()
            }
        }
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
