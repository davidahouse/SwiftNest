//
//  ViewController.swift
//  SwiftNestMac
//
//  Created by davidahouse on 7/7/18.
//  Copyright © 2018 davidahouse. All rights reserved.
//

import Cocoa

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
        listDialogCoordinator?.presentDialog(from: self.view.window!, model: ListableModel.testArray, title: "List Dialog", allowCancel: false) { selected in
            print("done!")
            print("selected: \(selected)")
            self.listDialogCoordinator = nil
        }
    }
}

