//
//  IMLPositionLineController.swift
//
//
//  Created by Théodore Roos on 2023-11-15.
//

public protocol IMLPositionLineController {
  func show()
  func hide()
  func showMLPath()
  func showFullMLPath()
  func showFullGPSPath()
  func showParticles()
  func showMLUser()
  func hideMLPath()
  func hideFullMLPath()
  func hideFullGPSPath()
  func hideParticles()
  func hideMLUser()
}
