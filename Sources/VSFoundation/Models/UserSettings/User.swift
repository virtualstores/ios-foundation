//
//  User.swift
//  PassiveDemoApp
//
//  Created by Hripsime on 2022-03-07.
//

import Foundation

final public class User: IPersistenceModel {
    public var retainOriginalIndex = false
    public var index: String?

    public init() {
        self.alpha = []
        self.beta = []
        self.y = []
    }
    
    convenience init(index: String) {
        self.init()
        self.index = index
    }

    public var id: String?
    public var userId: String?
    public var userHeight: Float?
    public var name: String?
    public var age: Int?
    public var gender: String?
    public var speedRegressionIntercept: Float?
    public var speedRegressionSlope: Float?
    public var alpha: [Float]?
    public var beta: [Float]?
    public var y: [Float]?
    public var noScanML: String?
}
