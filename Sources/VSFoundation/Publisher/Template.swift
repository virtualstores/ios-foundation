////
////  Template.swift
////  VSFoundation
////
////  Created by Gabriel Sabadin on 2021-12-20.
////  Copyright (c) 2021 Virtual Stores
////
//
//import Foundation
//import Combine
//
//public protocol Template: NSObjectProtocol {
//    associatedtype T
//}
//
//public protocol Combine: Template {
//    var subscriptions: Set<AnyCancellable> { get set }
//}
//
//public enum PublisherError: Error {
//    case network
//    case decoding
//    case encoding
//}
//
//extension PublisherError: CustomStringConvertible {
//    public var description: String {
//        switch self {
//        case .network:
//            return "network error"
//        case .decoding:
//            return "decoding error"
//        case .encoding:
//            return "encoding error"
//        }
//    }
//}
//
//public protocol Listener: Template {
//    func listen(receiveCompletion: @escaping ((Subscribers.Completion<PublisherError>) -> Void),
//                receiveValue: @escaping ((T) -> Void))
//
//    func listen(error on: @escaping ((Subscribers.Completion<PublisherError>) -> Void))
//
//    func listen(value on: @escaping ((T) -> Void))
//}
