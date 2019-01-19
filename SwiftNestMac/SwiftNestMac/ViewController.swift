//
//  ViewController.swift
//  SwiftNestMac
//
//  Created by davidahouse on 7/7/18.
//  Copyright © 2018 davidahouse. All rights reserved.
//

import Cocoa
import SwiftNest

class ViewController: NSViewController {

    var listDialogCoordinator: ListDialogCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func test(_ sender: Any) {
    
        listDialogCoordinator = ListDialogCoordinator()
        let list = ListableModels(models: ListableModel.testArray)
        listDialogCoordinator?.presentDialog(from: self.view.window!, model: list, title: "List Dialog", allowCancel: false) { selected in
            print("done!")
            print("selected: \(selected)")
            self.listDialogCoordinator = nil
        }
    }
}

