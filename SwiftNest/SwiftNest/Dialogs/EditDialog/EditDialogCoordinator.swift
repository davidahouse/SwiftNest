//
//  EditDialogCoordinator.swift
//
//  Created by davidahouse on 5/20/18.
//  Copyright © 2018 davidahouse. All rights reserved.
//

import AppKit

protocol EditDialogCoordinatorDelegate: class {
    func editDialogFinished()
    func saveEditable(model: Editable)
}

public class EditDialogCoordinator {

    weak var delegate: EditDialogCoordinatorDelegate?
    weak var fromWindow: NSWindow?
    weak var presentedWindow: NSWindow?
    var updatedModel: Editable?

    public func presentDialog(from: NSWindow, model: Editable, title: String, completion: @escaping (Editable) -> Void) {

        fromWindow = from
        let storyboard = NSStoryboard(name: "EditDialog", bundle: nil)
        if let windowController = storyboard.instantiateInitialController() as? EditDialogWindowController,
            let window = windowController.window,
            let viewController = windowController.contentViewController as? EditDialogViewController {

            presentedWindow = window
            window.title = title
            viewController.delegate = self
            viewController.editable = model
            from.beginSheet(window, completionHandler: { response in

                if response == .OK {
                    if let updatedModel = self.updatedModel {
                        completion(updatedModel)
                    } else {
                        completion(model)
                    }
                }

                DispatchQueue.main.async {
                    self.delegate?.editDialogFinished()
                }
            })
        }
    }
}

extension EditDialogCoordinator: EditDialogViewControllerDelegate {

    func cancelSelected() {

        guard let fromWindow = fromWindow, let presentedWindow = presentedWindow else {
            return
        }

        updatedModel = nil

        DispatchQueue.main.async {
            fromWindow.endSheet(presentedWindow, returnCode: .cancel)
        }
    }

    func okSelected(model: Editable) {

        guard let fromWindow = fromWindow, let presentedWindow = presentedWindow else {
            return
        }

        updatedModel = model

        delegate?.saveEditable(model: model)
        DispatchQueue.main.async {
            fromWindow.endSheet(presentedWindow, returnCode: .OK)
        }
    }
}
