//
//  Config.swift
//  VSFoundation
//
//  Created by Gabriel Sabadin on 2021-04-26.
//  Copyright Virtual Stores - 2021
//

import Foundation

public protocol Config: Disposable {
    func configure(_ injector: Injector)
    func deconfigure(_ injector: Injector)
}
