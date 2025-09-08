//
//  Context.swift
//  VSFoundation
//
//  Created by Gabriel Sabadin on 2021-04-26.
//  Copyright Virtual Stores - 2021
//

import Foundation

public protocol IContext {
    var injector: Injector { get }

    func configure(completion: () -> Void)
    func configure(_ configs: [Config], completion: () -> Void)
}

public class Context: IContext {
    private let tag = "Context"
    private let _injector: Injector = Injector.main
    private var config: Config?

    public var injector: Injector {
        return _injector
    }

    public init(_ config: Config) {
        self.config = config
        configure() {}
    }

    deinit {
      Logger(verbosity: .info).log(tag: tag, message: "deinit")
      dispose()
    }

    public func configure(completion: () -> Void) {
      if let config = config {
        configure([config], completion: completion)
      }
    }

    public func configure(_ configs: [Config], completion: () -> Void) {
        for config in configs {
            config.configure(injector)
        }

        completion()
    }

    public func deconfigure(completion: () -> Void) {
      if let config = config {
        Logger(verbosity: .info).log(tag: tag, message: "deconfigure")
        deconfigure([config], completion: completion)
      }
    }

    public func deconfigure(_ configs: [Config], completion: () -> Void) {
      for config in configs {
        config.deconfigure(injector)
      }

      completion()
    }

    public func release() {
        Injector.reset()
    }
}

extension Context: Disposable {
  public func dispose() {
    Logger(verbosity: .info).log(tag: tag, message: "dispose")
    deconfigure {
      Injector.reset()
      config = nil
    }
  }
}
