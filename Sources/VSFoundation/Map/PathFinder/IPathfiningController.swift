//
//  IPathfiningController.swift
//  
//
//  Created by Théodore Roos on 2022-03-30.
//

import Foundation
import CoreGraphics
import Combine

/**
 * Pathfinding controller. Methods for controlling the path between goals and to help a user find the fastest way to them.
 *
 * @constructor Create empty constructor for pathfinding controller
 */
public protocol IPathfindingController {

  var state: State { get }

  /**
   * On current goal change. Gives updates whenever a change happends in the pathfinding order.
   *
   * @param goal Goal
   */
  var onCurrentGoalChangePublisher: CurrentValueSubject<PathfindingGoal?, Never> { get }

  /**
   * On sorted goal change. Gives updates when pathfiding goal order is deviated from.
   *
   * @param goals Goals
   */
  var onSortedGoalChangePublisher: CurrentValueSubject<[PathfindingGoal], Never> { get }
  /**
   * Current goal is the most optimal goal to go to first given a list of goals.
   * Current goal is the goal that the pathfinding head will go towards and this goal is the same as the first on in [sortedGoals].
   */
  var currentGoal: PathfindingGoal? { get }

  /**
   * Sorted goals contains the list of goals witch are in the most optimal visit order.
   */
  var sortedGoals: [PathfindingGoal] { get }

  /**
   * Add goal for pathfinding.
   * It's recommended to [addGoal] with a mark [MarkerController.addMark] and use the same data.
   *
   * @param goal Goal
   * @param callback Callback
   */
  func add(goal: PathfindingGoal, completion: @escaping (() -> Void))

  /**
   * Add goals. adds a list of goals to pathfinding.
   *
   * @param goals Goals
   * @param callback Callback
   */
  func add(goals: [PathfindingGoal], completion: @escaping (() -> Void))

  /**
   * Set goals. Removes previously added goals and replaces them with the input.
   *
   * @param goals Goals
   * @param callback Callback
   */
  func set(goals: [PathfindingGoal], completion: @escaping (() -> Void))

  /**
   * Remove goal. Removes a single goal from pathfinding.
   *
   * @param id Id
   * @param callback Callback
   */
  func remove(goal: PathfindingGoal, completion: @escaping (() -> Void))

  /**
   * Remove goals. removes a list of goals from pathfinding.
   *
   * @param ids Ids
   * @param callback Callback
   */
  func remove(goals: [PathfindingGoal], completion: @escaping (() -> Void))

  /**
   * Pop goal. Removes the first goal of the pathfinding.
   */
  func popGoal()

  /**
   * Show pathfinding. Makes the drawn pathfinding lines visible on the map.
   */
  func showPathfinding()

  /**
   * Show tail. Shows a drawn path from the last goal to a stop location of the store.
   *
   */
  func showTail()

  /**
   * Show body. Shows a drawn path between all goals between the first and the last.
   */
  func showBody()

  /**
   * Show head. Shows a drawn path from the users position to the first goal.
   */
  func showHead()

  /**
   * Hide pathfinding. Hides all pathfinding lines.
   */
  func hidePathfinding()

  /**
   * Hide tail. Hides the drawn path from the last goal to the stop location.
   */
  func hideTail()

  /**
   * Hide body. Hides all paths between the first goal to the last.
   */
  func hideBody()

  /**
   * Hide head. Hides the path between the users location to the first goal.
   */
  func hideHead()

  /**
   * Has goal. Returns true if [PathfindingController] has at least one goal.
   *
   * @return
   */
  func hasGoal() -> Bool

  /**
   * Update location. Updates [PathfindingController] with new user positions.
   * This methods needs to be called on new position events for the [PathfindingController] to work correctly.
   *
   * @param newLocation New location
   */
  func updateLocation(newLocation: CGPoint)

  /**
   * Force refresh. Reruns algorithm for finding the optimal way between all set goals.
   *
   * @param withTSP If true the optimal order of goals will be calculated again and an new goal order will be given. If false the path to the first goal will be updated.
   * @param overridePosition Override position
   * @param callback Callback
   */
  func forceRefresh(withTSP: Bool, overridePosition: CGPoint?, completion: @escaping (() -> Void))
}

public enum State {
  case active, hidden
}

/**
 * Pathfinding goal. The data class that is used for creating a goal for the [PathfindingController]
 *
 * @param T
 * @constructor Create empty constructor for pathfinding goal
 */
public struct PathfindingGoal {
  public let id: String
  public let position: CGPoint
  public let data: Any?
  public let type: GoalType
  public let floorLevelId: Int64?

  public init(id: String, position: CGPoint, data: Any?, type: GoalType, floorLevelId: Int64?) {
    self.id = id
    self.position = position
    self.data = data
    self.type = type
    self.floorLevelId = floorLevelId
  }

  /**
   * Type. Set up a start and stop goal to choose at what side of the store the pathfinding should end at.
   *
   * @constructor Create empty constructor for type
   */
  public enum GoalType {
    case end
    case start
    case target
  }
}
