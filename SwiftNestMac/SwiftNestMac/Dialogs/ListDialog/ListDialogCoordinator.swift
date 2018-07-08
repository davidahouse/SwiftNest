//
//  ListDialogCoordinator.swift
//
//  Created by davidahouse on 5/28/18.
//  Copyright © 2018 davidahouse. All rights reserved.
//

import AppKit

protocol ListDialogCoordinatorDelegate: class {
    func listDialogFinished()
}

class ListDialogCoordinator {
    
    weak var delegate: ListDialogCoordinatorDelegate?
    weak var fromWindow: NSWindow?
    weak var presentedWindow: NSWindow?
    
    func presentDialog(from: NSWindow, model: Listable, title: String, completion: @escaping () -> Void) {
        
        fromWindow = from
        let storyboard = NSStoryboard(name: "ListDialog", bundle: nil)
        if let windowController = storyboard.instantiateInitialController() as? ListDialogWindowController, let window = windowController.window, let viewController = windowController.contentViewController as? ListDialogViewController {

            presentedWindow = window
            window.title = title
            viewController.delegate = self
            viewController.model = model
            viewController.preferredContentSize = NSSize(width: from.frame.size.width - 100, height: from.frame.size.height - 100)
            from.beginSheet(window, completionHandler: { response in
                completion()
            })
        }
    }
}

extension ListDialogCoordinator: ListDialogViewControllerDelegate {
    
    func okSelected() {
        
        guard let fromWindow = fromWindow, let presentedWindow = presentedWindow else {
            return
        }
        
        DispatchQueue.main.async {
            fromWindow.endSheet(presentedWindow, returnCode: .OK)
        }
    }
}
