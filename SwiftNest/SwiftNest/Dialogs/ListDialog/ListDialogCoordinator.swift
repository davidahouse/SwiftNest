//
//  ListDialogCoordinator.swift
//
//  Created by davidahouse on 5/28/18.
//  Copyright © 2018 davidahouse. All rights reserved.
//

import AppKit

public class ListDialogCoordinator {

    weak var fromWindow: NSWindow?
    weak var presentedWindow: NSWindow?
    var selectedIdentifier: String?

    public init() { }

    public func presentDialog(from: NSWindow, model: Listable, title: String, allowCancel: Bool = true,
                       completion: @escaping (String?) -> Void) {

        fromWindow = from
        let storyboard = NSStoryboard(name: "ListDialog", bundle: Bundle(for: ListDialogCoordinator.self))
        if let windowController = storyboard.instantiateInitialController() as? ListDialogWindowController,
            let window = windowController.window,
            let viewController = windowController.contentViewController as? ListDialogViewController {

            presentedWindow = window
            window.title = title
            viewController.delegate = self
            viewController.model = model
            viewController.allowCancel = allowCancel
            viewController.preferredContentSize = NSSize(width: from.frame.size.width / 2.0,
                                                         height: from.frame.size.height / 2.0)
            from.beginSheet(window, completionHandler: { _ in
                completion(self.selectedIdentifier)
            })
        }
    }
}

extension ListDialogCoordinator: ListDialogViewControllerDelegate {

    func cancelSelected() {

        selectedIdentifier = nil

        guard let fromWindow = fromWindow, let presentedWindow = presentedWindow else {
            return
        }

        DispatchQueue.main.async {
            fromWindow.endSheet(presentedWindow, returnCode: .OK)
        }
    }

    func itemSelected(identifier: String) {
        selectedIdentifier = identifier
    }

    func okSelected() {

        guard let fromWindow = fromWindow, let presentedWindow = presentedWindow else {
            return
        }

        DispatchQueue.main.async {
            fromWindow.endSheet(presentedWindow, returnCode: .OK)
        }
    }
}
