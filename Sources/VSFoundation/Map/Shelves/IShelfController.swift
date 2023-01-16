//
//  IShelfController.swift
//  
//
//  Created by Théodore Roos on 2022-06-10.
//

import Foundation
import Combine

/**
 * Shelf controller.
 *
 * @constructor Create empty constructor for shelf controller
 */
public protocol IShelfController {
  //TODO: check what type och shelves are in shelves variable.
  /**
   * List of all shelves that has been set up.
   */
  var shelves: [Shelf] { get }

  var onShelfClicked: CurrentValueSubject<Shelf?, Never> { get }

  /**
   * Set shelves. Sets a collection of [ShelfGroup].
   *
   * @param shelves Shelves
   */
  func setShelves(shelves: [ShelfGroup])

  /**
   * Show all shelf layers. Makes all shelf layers visible. These include, shelf fill layer, shelf outline layer, shelf mark layer.
   */
  func showAllShelfLayers()

  /**
   * Hide all shelf layers. Hide all shelf layers. These include, shelf fill layer, shelf outline layer, shelf mark layer.
   */
  func hideAllShelfLayers()

  /**
   * Show shelves line layer. Show outlines of all shelves.
   */
  func showShelvesLineLayer()

  /**
   * Show shelves mark layer. Show all shelf marks places on shelves.
   */
  func showShelvesMarkLayer()

  /**
   * Show shelves fill layer. Makes all shelves and their core shape visible.
   */
  func showShelvesFillLayer()

  /**
   * Hide shelves line layer. Makes all shelf outlines invisible.
   */
  func hideShelvesLineLayer()

  /**
   * Hide shelves mark layer. Makes all marks on shelves invisible.
   */
  func hideShelvesMarkLayer()

  /**
   * Hide shelves fill layer. Makes all shelves and their core shape invisible.
   */
  func hideShelvesFillLayer()

  /**
   * Show. Makes a shelf visible.
   *
   * @param shelf Shelf
   */
  func show(shelf: Shelf)

  /**
   * Show all. Show all shelves.
   */
  func showAll()

  /**
   * Hide. Makes a shelf invisible.
   *
   * @param shelf Shelf
   */
  func hide(shelf: Shelf)

  /**
   * Hide all. Makes all shelves invisible.
   */
  func hideAll()

  /**
   * Select. Select and highlight a shelf.
   *
   * @param shelf Shelf
   */
  func select(shelf: Shelf?)

  /**
   * Deselect. Deselect and unhighlight a selected shelf.
   *
   * @param shelf Shelf
   */
  func deselect(shelf: Shelf?)

  /**
   * Deselect all. Deselect all selected shelves.
   */
  func deselectAll()

  /**
   * Mark shelf. Place a mark on shelf. It is visualized by a dot on the shelf.
   *
   * @param shelf Shelf
   */
  func markShelf(shelf: Shelf)

  /**
   * Clear marked shelf. Remove mark on shelf.
   *
   * @param shelf Shelf
   */
  func clearMarkedShelf(shelf: Shelf)

  /**
   * Clear all marked shelves.
   */
  func clearAllMarkedShelves()
}
