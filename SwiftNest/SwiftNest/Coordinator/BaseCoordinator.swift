//
//  BaseCoordinator.swift
//  Lincoln
//
//  Created by David House on 11/1/18.
//  Copyright © 2018 davidahouse. All rights reserved.
//

import Foundation

enum CoordinatorEventDirection {
    case both
    case parent
    case child
}

open class BaseCoordinator<T, D> {

    let coordinatorID: String
    let parentCoordinator: BaseCoordinator?
    var childCoordinators = [BaseCoordinator]()
    public let dependencies: D

    public init(parent: BaseCoordinator? = nil, dependencies: D) {
        coordinatorID = UUID().uuidString
        parentCoordinator = parent
        self.dependencies = dependencies
    }

    public func addChild(coordinator: BaseCoordinator) {
        childCoordinators.append(coordinator)
    }

    public func findChild(_ coordinatorID: String) -> BaseCoordinator? {
        return childCoordinators.first(where: { (coordinator) -> Bool in
            coordinator.coordinatorID == coordinatorID
        })
    }

    /**
     send an event to the entire coordinator chain while also giving the
     coordinator a chance to handle it
    **/
    public func send(event: T) {
        send(event: event, sourceID: coordinatorID)
    }

    private func send(event: T, sourceID: String) {
        if !handle(event: event) {

            // Don't send to parent if sourceID matches our parents ID
            if sourceID != parentCoordinator?.coordinatorID {
                parentCoordinator?.send(event: event, sourceID: coordinatorID)
            }

            // Send to children unless sourceID matches one of their IDs
            childCoordinators.forEach {
                if $0.coordinatorID != sourceID {
                    $0.send(event: event, sourceID: coordinatorID)
                }
            }
        }
    }

    open func handle(event: T) -> Bool {
        return false
    }
}
