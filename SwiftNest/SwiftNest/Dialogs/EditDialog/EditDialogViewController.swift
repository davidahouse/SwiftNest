//
//  EditDialogViewController.swift
//
//  Created by David House on 5/20/18.
//  Copyright © 2018 davidahouse. All rights reserved.
//

import AppKit

protocol EditDialogViewControllerDelegate: class {
    func cancelSelected()
    func okSelected(model: Editable)
}

class EditDialogViewController: NSViewController {

    // MARK: - Properties
    private var formFields = [String: EditableField]()

    var editable: Editable? {
        didSet {
            self.createEditForm()
        }
    }
    weak var delegate: EditDialogViewControllerDelegate?

    // MARK: - IBOutlets
    @IBOutlet var formView: NSView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Private Methods
    private func createEditForm() {
        guard let editFields = editable?.details() else {
            return
        }

        var gridViews = [[NSView]]()

        for edit in editFields {
            let label = NSTextField(labelWithString: edit.label())
            let field = edit.editField()
            formFields[edit.label()] = field
            gridViews.append([label, field])
        }

        let gridView = NSGridView(views: gridViews)
        view.addSubview(gridView)
        gridView.frame = formView.frame
    }

    @IBAction func cancelSelected(_ sender: Any) {
        delegate?.cancelSelected()
    }

    @IBAction func okSelected(_ sender: Any) {

        guard let editable = editable else {
            delegate?.cancelSelected()
            return
        }

        var updatedFields = [EditDetail]()
        let editFields = editable.details()

        for edit in editFields {

            if let field = formFields[edit.label()] {

                let updated: EditDetail = {
                    switch field.kind {
                    case .text:
                        if let value = field.toString(), value.trimmingCharacters(in: .whitespaces) != "" {
                            return edit.updated(value: field.toString())
                        } else {
                            return edit
                        }
                    case .date:
                        return edit.updated(dateValue: field.toDate())
                    case .currency:
                        return edit.updated(doubleValue: field.toDouble())
                    case .accountType:
                        return edit.updated(value: field.toString())
                    }
                }()
                updatedFields.append(updated)
            }
        }

        let result = editable.updated(details: updatedFields)
        delegate?.okSelected(model: result)
    }
}
