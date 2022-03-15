//
//  User.swift
//  PassiveDemoApp
//
//  Created by Hripsime on 2022-03-07.
//

import Foundation

final public class User {
    public var id: String?
    public var userId: String?
    public var userHeight: Float?
    public var name: String?
    public var age: String?
    public var gender: String?
    
    public init(id: String?, userId: String?, userHeight: Float?, name: String?, age: String?, gender: String?) {
        self.id = id
        self.userId = userId
        self.userHeight = userHeight
        self.name = name
        self.age = age
        self.gender = gender
    }
}
