// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "VSFoundation",
  platforms: [
    .iOS(.v13),
    .macOS(.v11),
    .watchOS(.v6)
  ],
  products: [
    .library(
      name: "VSFoundation",
      targets: ["VSFoundation"]),
  ],
  dependencies: [],
  targets: [
    .target(
      name: "VSFoundation",
      dependencies: []),
    .testTarget(
      name: "VSFoundationTests",
      dependencies: ["VSFoundation"],
      resources: [
        .copy("TestResources/ReplayDataTests/")
      ])
  ]
)
