// ReplayDataV2.swift
// VSFoundation

// Created by: CJ on 2022-01-04
// Copyright (c) 2021 Virtual Stores
import Foundation

public protocol IUserSettings {
    func setUser(user: User)
    
    func getUser(userId: String) -> User?
    
    func clearAllUserSettings()
    
    func clearUser(userId: String)
}
