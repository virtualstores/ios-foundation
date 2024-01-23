//
//  PathfinderProtocol.swift
//  PositionKit
//
//  Created by Théodore Roos on 2021-10-26.
//

import Foundation
import Combine
import UIKit

public protocol IPathfinder {
    /// Publisher for rcurrent goal update
    var currentGoalUpdatedPublisher: CurrentValueSubject<Goal?, Never> { get }

    /// Publisher for  goal update
    var sortedGoalUpdatedPublisher: CurrentValueSubject<[Goal]?, Never> { get }

    /// Publisher for  path update
    var pathUpdatedPublisher: CurrentValueSubject<Path?, Never> { get }

    /// Publisher for  path checking if goal exists
    var hasGoal: CurrentValueSubject<Bool, Never> { get }

    /// Set User Position from VPS
    func setUserPosition(position: CGPoint?)

    /// Add goal from VPS
    func add(goal: Goal, completion: @escaping () -> Void)

    /// Add goals from VPS
    func add(goals: [Goal], completion: @escaping () -> Void)

    /// Set new goals from VPS
    func set(goals: [Goal], completion: @escaping () -> Void)

    /// Remove goal from VPS
    func remove(id: String, completion: @escaping () -> Void)

    /// Remove goals from VPS
    func remove(ids: [String], completion: @escaping () -> Void)

    /// Pop Goal to VPS
    func popGoal()

    /// Force refresh  VPS pathfinder
    func forceRefresh(withTSP: Bool, overridePosition: CGPoint?, completion: @escaping () -> Void)
}
