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
    /// Publisher for current goal update
    var currentGoalUpdatedPublisher: CurrentValueSubject<Goal?, Never> { get }

    var goalsUpdatedPublisher: CurrentValueSubject<[Goal]?, Never> { get }

    /// Publisher for  goal update
    var sortedGoalUpdatedPublisher: CurrentValueSubject<[Goal]?, Never> { get }

    /// Publisher for  path update
    var pathUpdatedPublisher: CurrentValueSubject<Path?, Never> { get }

    /// Publisher for  path checking if goal exists
    var hasGoal: Bool { get }

    /// Set User Position from VPS
    func setUserPosition(position: CGPoint?)

    /// Add goal from VPS
    func add(goal: Goal, completion: (() -> ())?)

    /// Add goals from VPS
    func add(goals: [Goal], completion: (() -> ())?)

    /// Set new goals from VPS
    func set(goals: [Goal], completion: (() -> ())?)

    /// Remove goal from VPS
    func remove(id: String, completion: (() -> ())?)

    /// Remove goals from VPS
    func remove(ids: [String], completion: (() -> ())?)

    /// Pop Goal to VPS
    func popGoal()

    /// Force refresh  VPS pathfinder
    func forceRefresh(withTSP: Bool, overridePosition: CGPoint?, completion: (() -> ())?)
}
