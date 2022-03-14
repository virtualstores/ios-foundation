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
  dependencies: [
   // .package(url: "https://github.com/stephencelis/SQLite.swift.git", .exact("0.13.1")),
  ],
  targets: [
    .target(
      name: "VSFoundation",
      dependencies: [
      //  .product(name: "SQLite", package: "SQLite.swift"),
]),
    .testTarget(
      name: "VSFoundationTests",
      dependencies: ["VSFoundation"],
      resources: [
        .copy("TestResources/ReplayDataTests/")
      ])
  ]
)
